class OauthAccessController < ApplicationController
  def create    
    options = {
      :body => {
        :grant_type => :authorization_code, 
        :client_id => OauthVpsa.settings['client_id'], 
        :client_secret => OauthVpsa.settings['client_secret'],
        :redirect_uri => OauthVpsa.settings['redirect_uri'],
        :code => params[:code] 
      }.to_json,
      :headers => { 'Content-Type' => 'application/json' }
    }
    
    resposta = HTTParty.post(OauthVpsa.settings['url_token'], options)

    session['access_token'] = resposta.parsed_response['access_token']
        
    redirect_to root_url
  end  
end
