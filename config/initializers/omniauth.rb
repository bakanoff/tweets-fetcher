OmniauthData = YAML.load_file(Rails.root.join('config', 'omniauth_keys.yml'))['omniauth_keys']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, OmniauthData['twitter']['token'], OmniauthData['twitter']['secret']
  provider :instagram, OmniauthData['instagram']['token'], OmniauthData['instagram']['secret']
end