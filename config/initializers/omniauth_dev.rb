OmniAuth.config.logger = Rails.logger

if Rails.env == 'development'
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :vpsa, "50a0ec6670a7df140800003a", "f18aafa1992290e30e1dd4ebeb130905a11a912068c1827fc1dd2c43f1b124dc",  {
      redirect_uri:'http://localhost:3000/auth/vpsa/callback'
    }     
  end
end