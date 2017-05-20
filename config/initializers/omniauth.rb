OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, 
   :scope => 'public_profile,email', info_fields: "id,first_name,last_name,link",
   :redirect_uri => 'http://localhost:6379/auth/facebook/callback/'

end
