class ApplicationController < ActionController::Base
  protect_from_forgery

  def access_token(provider)
    return nil if session[:omniauth_auth].nil? or session[:omniauth_auth][provider.to_s].nil?

    refresh_token = session[:omniauth_auth][provider.to_s][:credentials][:refresh_token]
    expires_at = session[:omniauth_auth][provider.to_s][:credentials][:expires_at]

    return nil if refresh_token and Time.now.to_i >= expires_at
    session[:omniauth_auth][provider.to_s][:credentials][:token]
  end

  def set_access_token(provider, new_auth_hash)
  	if session[:omniauth_auth].nil?
  		session[:omniauth_auth] = Hash.new
  	end 

  	session[:omniauth_auth][provider] = new_auth_hash
  end

  def info(provider)
    return nil if session[:omniauth_auth].nil? or session[:omniauth_auth][provider.to_s].nil?
    session[:omniauth_auth][provider.to_s][:info]
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def verificar_token(provider)
    session[:redirect_after_oauth] = request.path
    redirect_to "/auth/#{provider.to_s}" unless access_token(provider.to_s)
  end
end
