Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '', '', setup: true
  provider :facebook, '', '', setup: true, scope: 'email'
end

OmniAuth.config.on_failure = Proc.new do |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
end
