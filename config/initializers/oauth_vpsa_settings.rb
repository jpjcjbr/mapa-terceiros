module OauthVpsa
  def self.settings
    @settings ||= YAML.load_file("#{Rails.root}/config/oauth_vpsa.yml")
    @settings[Rails.env]
  end
end
