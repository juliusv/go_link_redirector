APP_CONFIG = YAML.load_file(Rails.root.join('config', 'config.yml'))[Rails.env]

APP_ID = APP_CONFIG['google_oauth2']['client_id']
APP_SECRET = APP_CONFIG['google_oauth2']['client_secret']

require 'omniauth-google-oauth2'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, APP_ID, APP_SECRET,
    { access_type: 'online', scope: 'https://www.googleapis.com/auth/userinfo.email', approval_prompt: '' }
end
