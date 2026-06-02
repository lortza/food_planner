# frozen_string_literal: true

require "rails_helper"

RSpec.describe UrlSafetyValidator, type: :service do
  describe ".safe?" do
    context "with a public http(s) host" do
      before { allow(Resolv).to receive(:getaddresses).and_return(["93.184.216.34"]) }

      it "is true for https" do
        expect(UrlSafetyValidator.safe?("https://example.com/recipe")).to be(true)
      end

      it "is true for http" do
        expect(UrlSafetyValidator.safe?("http://example.com/recipe")).to be(true)
      end
    end

    context "with a disallowed scheme" do
      it "rejects file://" do
        expect(UrlSafetyValidator.safe?("file:///etc/passwd")).to be(false)
      end

      it "rejects ftp://" do
        allow(Resolv).to receive(:getaddresses).and_return(["93.184.216.34"])
        expect(UrlSafetyValidator.safe?("ftp://example.com/file")).to be(false)
      end
    end

    context "when the host resolves to an internal address" do
      {
        "loopback" => "127.0.0.1",
        "RFC-1918 (10/8)" => "10.0.0.5",
        "RFC-1918 (192.168/16)" => "192.168.1.1",
        "link-local / cloud metadata" => "169.254.169.254",
        "unspecified" => "0.0.0.0",
        "IPv6 loopback" => "::1",
        "IPv6 ULA" => "fc00::1"
      }.each do |description, address|
        it "rejects #{description} (#{address})" do
          allow(Resolv).to receive(:getaddresses).and_return([address])
          expect(UrlSafetyValidator.safe?("https://internal.example.com")).to be(false)
        end
      end

      it "rejects an IPv4-mapped IPv6 loopback" do
        allow(Resolv).to receive(:getaddresses).and_return(["::ffff:127.0.0.1"])
        expect(UrlSafetyValidator.safe?("https://internal.example.com")).to be(false)
      end

      it "rejects when any one of several resolved addresses is internal" do
        allow(Resolv).to receive(:getaddresses).and_return(["93.184.216.34", "127.0.0.1"])
        expect(UrlSafetyValidator.safe?("https://example.com")).to be(false)
      end
    end

    context "with an IP literal host" do
      it "rejects a private IP without resolving DNS" do
        expect(Resolv).not_to receive(:getaddresses)
        expect(UrlSafetyValidator.safe?("https://10.0.0.1/recipe")).to be(false)
      end
    end

    context "when the host cannot be resolved" do
      it "is false" do
        allow(Resolv).to receive(:getaddresses).and_raise(Resolv::ResolvError)
        expect(UrlSafetyValidator.safe?("https://nope.invalid")).to be(false)
      end

      it "is false when resolution returns no addresses" do
        allow(Resolv).to receive(:getaddresses).and_return([])
        expect(UrlSafetyValidator.safe?("https://nope.invalid")).to be(false)
      end
    end

    it "is false for a URL with no host" do
      expect(UrlSafetyValidator.safe?("https:///norhost")).to be(false)
    end
  end

  describe ".validate!" do
    it "raises UnsafeUrl for an internal address" do
      allow(Resolv).to receive(:getaddresses).and_return(["127.0.0.1"])
      expect { UrlSafetyValidator.validate!("https://internal.example.com") }
        .to raise_error(UrlSafetyValidator::UnsafeUrl)
    end

    it "returns the validator for a safe URL" do
      allow(Resolv).to receive(:getaddresses).and_return(["93.184.216.34"])
      expect(UrlSafetyValidator.validate!("https://example.com")).to be_a(UrlSafetyValidator)
    end
  end
end
