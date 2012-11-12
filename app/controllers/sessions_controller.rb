class SessionsController < ApplicationController
  def create
  	set_access_token(params[:provider], auth_hash)

  	if session[:redirect_after_oauth]
  		redirect_to session[:redirect_after_oauth]
  	else
      render '/'
  	end
  end

  def destroy
  	reset_session  	
  end
end