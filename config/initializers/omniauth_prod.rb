OmniAuth.config.logger = Rails.logger

if Rails.env == 'production'
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :vpsa, "50533a04d93a4b7a7c00000d", "3463798f6a4c10b1b998634f7c3b3fff713362abaf6153bd428b0219e6144e1d",  {
      redirect_uri:'http://mapa-terceiros.herokuapp.com/oauth/vpsa/callback'
    }
  end
end