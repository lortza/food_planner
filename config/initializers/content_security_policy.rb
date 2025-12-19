# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.img_src     :self, :data, :https
    policy.object_src  :none

    # Allow fonts from your domain and specific CDNs
    policy.font_src    :self, :data, 
                       'https://fonts.googleapis.com',
                       'https://fonts.gstatic.com',
                       'https://stackpath.bootstrapcdn.com'

    # Allow scripts from your domain and specific CDNs
    policy.script_src  :self, 
                       'https://stackpath.bootstrapcdn.com',
                       'https://code.jquery.com',
                       'https://cdn.jsdelivr.net',
                       'https://cdnjs.cloudflare.com'

    # Allow styles from your domain and specific CDNs and disallow inline styles
    policy.style_src   :self,
                       'https://fonts.googleapis.com/', 
                       'https://stackpath.bootstrapcdn.com',
                       'https://cdn.jsdelivr.net',
                       'https://cdnjs.cloudflare.com'

    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end

  # Generate session nonces for permitted importmap and inline scripts
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w(script-src style-src)

  # Report violations without enforcing the policy.
  config.content_security_policy_report_only = true
end
