require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "201255556067.apps.googleusercontent.com", " nDHRgf_bxADXoXmhG9gfVv2L", {:redirect_path => "/teams/:team_id/people", :ssl_ca_file => "/etc/ssl/certs/curl-ca-bundle.crt"}
end
