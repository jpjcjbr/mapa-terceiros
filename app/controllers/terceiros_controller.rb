class TerceirosController < ApplicationController
  def index
    if session['access_token']
      
      options = {
        :body => { :token => session['access_token'] }.to_json,
        :headers => { 'Content-Type' => 'application/json' }
      }
      
      terceiros_vpsa = HTTParty.get('https://vpsa-oauth-server.herokuapp.com/terceiros.json', options)

      @terceiros = Array.new

      terceiros_vpsa.each do |terceiro_vpsa|
        terceiro = Terceiro.new
        terceiro.nome = terceiro_vpsa['nome']
        terceiro.id = terceiro_vpsa['id']
        terceiro.endereco = self.endereco(terceiro_vpsa)
        @terceiros << terceiro
      end
    else
      redirect_to '/auth/oauth'
    end
  end

  def mapa    
    if session['access_token']
     
      options = {
        :body => { :token => session['access_token'] }.to_json,
        :headers => { 'Content-Type' => 'application/json' }
      }
      
      terceiro_vpsa = HTTParty.get('https://vpsa-oauth-server.herokuapp.com/terceiros/' + params[:id].to_s + '.json', options)
      
      pesquisa = Geocoder.search(self.endereco(terceiro_vpsa))

      @terceiro = Terceiro.new
      @terceiro.nome = terceiro_vpsa['nome']

      if pesquisa[0]
        @latitude = pesquisa[0].geometry['location']['lat']
        @longitude = pesquisa[0].geometry['location']['lng']
        @endereco_formatado = pesquisa[0].formatted_address
      else
        @latitude = 0
        @longitude = 0
      end
    else
      redirect_to '/auth/oauth'
    end
  end
  
  def endereco(terceiro)
    return '' if !terceiro['endereco']
    endereco = terceiro['endereco']['logradouro'].to_s + ","
    endereco = endereco + terceiro['endereco']['bairro'].to_s + ','
    endereco = endereco + terceiro['endereco']['cidade'].to_s + ','
    endereco = endereco + terceiro['endereco']['pais'].to_s
    return endereco
  end
end
