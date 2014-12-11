# If any env files exist other than .env, add them as arguments to #load
Dotenv.load
APP_CONFIG = YAML.load(ERB.new(File.read(Rails.root.join("config", "config.yml"))).result)[Rails.env]

APP_ID = APP_CONFIG['google_oauth2']['client_id']
APP_SECRET = APP_CONFIG['google_oauth2']['client_secret']

require 'omniauth-google-oauth2'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, APP_ID, APP_SECRET,
    { access_type: 'online', scope: 'https://www.googleapis.com/auth/userinfo.email', approval_prompt: '' }
end
