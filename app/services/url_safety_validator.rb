# frozen_string_literal: true

require "resolv"
require "ipaddr"

# Guards against SSRF when fetching user-supplied URLs (recipe source URLs and
# the print links discovered on those pages). It restricts the scheme to
# http/https and rejects any URL whose host resolves to a private, loopback,
# link-local, or otherwise reserved address.
#
# Note: this validates the addresses a host resolves to at call time. It does
# not close the TOCTOU/DNS-rebinding gap (a host could resolve differently
# between validation and the actual connection); fully closing that requires
# pinning the connection to the validated IP. See issue #1310.
class UrlSafetyValidator
  class UnsafeUrl < StandardError; end

  ALLOWED_SCHEMES = %w[http https].freeze

  # Ranges not covered by IPAddr#loopback?/#private?/#link_local? that we still
  # want to block (unspecified, CGNAT, test/benchmark/reserved, multicast, etc.).
  BLOCKED_RANGES = [
    "0.0.0.0/8",          # "this" network / unspecified
    "100.64.0.0/10",      # carrier-grade NAT
    "192.0.0.0/24",       # IETF protocol assignments
    "192.0.2.0/24",       # TEST-NET-1
    "192.88.99.0/24",     # deprecated 6to4 relay anycast (RFC 7526)
    "198.18.0.0/15",      # benchmarking
    "198.51.100.0/24",    # TEST-NET-2
    "203.0.113.0/24",     # TEST-NET-3
    "224.0.0.0/4",        # multicast
    "240.0.0.0/4",        # reserved
    "255.255.255.255/32", # broadcast
    "::/128",             # IPv6 unspecified
    "ff00::/8",           # IPv6 multicast
    "2002::/16"           # 6to4
  ].map { |cidr| IPAddr.new(cidr) }.freeze

  def self.safe?(url)
    new(url).safe?
  end

  def self.validate!(url)
    new(url).validate!
  end

  def initialize(url)
    @url = url
  end

  def safe?
    validate!
    true
  rescue UnsafeUrl
    false
  end

  def validate!
    uri = parse_uri
    validate_scheme!(uri)
    validate_host!(uri)
    self
  end

  private

  def parse_uri
    URI.parse(@url.to_s)
  rescue URI::InvalidURIError
    raise UnsafeUrl, "Invalid URL"
  end

  def validate_scheme!(uri)
    unless ALLOWED_SCHEMES.include?(uri.scheme)
      raise UnsafeUrl, "Disallowed scheme: #{uri.scheme.inspect}"
    end
  end

  def validate_host!(uri)
    host = uri.host
    raise UnsafeUrl, "Missing host" if host.blank?

    addresses = resolve(host)
    raise UnsafeUrl, "Could not resolve host: #{host}" if addresses.empty?

    addresses.each do |address|
      raise UnsafeUrl, "Disallowed address: #{address}" if blocked_ip?(IPAddr.new(address))
    end
  end

  def resolve(host)
    return [host] if ip_literal?(host)

    Resolv.getaddresses(host)
  rescue Resolv::ResolvError
    []
  end

  def ip_literal?(host)
    IPAddr.new(host)
    true
  rescue IPAddr::InvalidAddressError
    false
  end

  def blocked_ip?(ip)
    ip = ip.native # unwrap IPv4-mapped IPv6 (e.g. ::ffff:127.0.0.1) to its IPv4 form
    ip.loopback? || ip.private? || ip.link_local? ||
      BLOCKED_RANGES.any? { |range| range.include?(ip) }
  end
end
