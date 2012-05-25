class AuthController < ApplicationController
  def oauth
    redirect_to url_oauth_vpsa
  end
  
  private
  def url_oauth_vpsa
    site = OauthVpsa.settings['url_authorization'] + '?'
    site << 'response_type=code&'
    site << 'scope=all&'
    site << 'client_id=' + OauthVpsa.settings['client_id'] + '&'
    site << 'redirect_uri=' + OauthVpsa.settings['redirect_uri']
  end
end