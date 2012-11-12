class TerceirosController < ApplicationController
  before_filter { |c| c.verificar_token :vpsa }

  def index
    token = access_token :vpsa
      
    terceiros_vpsa = HTTParty.get("https://www.vpsa.com.br/apps/api/terceiros?token=#{token}")

    @terceiros = Array.new

    terceiros_vpsa.each do |terceiro_vpsa|
      puts "------"
      p terceiro_vpsa


      #{"id"=>114, "nome"=>"JOAQUIM DE SOUZA NETO", "documento"=>"655.332.455-70", "emails"=>["joaquim.neto@hotmail.com"], "enderecos"=>[{"tipo"=>"RUA", "logradouro"=>"PROJETADA", "numero"=>"246", "bairro"=>"MANDACARU", "cep"=>"58013021", "cidade"=>"JoÃ£o Pessoa", "siglaEstado"=>"PB", "pais"=>"BRASIL"}], "telefones"=>[{"ddi"=>"0", "ddd"=>"83", "numero"=>"32102543"}], "classes"=>["PRESTADOR_SERVICO"]}

      terceiro = Terceiro.new
      terceiro.nome = terceiro_vpsa['nome']
      terceiro.email = terceiro_vpsa['emails'][0] if terceiro_vpsa['emails']
      terceiro.id = terceiro_vpsa['id']
      terceiro.endereco = self.endereco(terceiro_vpsa)
      @terceiros << terceiro
    end
  end

  def mapa  
    token = access_token :vpsa
      
    terceiro_vpsa = HTTParty.get("https://www.vpsa.com.br/apps/api/terceiros/#{params[:id].to_s}?token=#{token}")
    
    pesquisa = Geocoder.search(self.endereco(terceiro_vpsa))

    @terceiro = Terceiro.new
    @terceiro.nome = terceiro_vpsa['nome']
    @terceiro.email = terceiro_vpsa['emails'][0] if terceiro_vpsa['emails']

    if pesquisa[0]
      @latitude = pesquisa[0].geometry['location']['lat']
      @longitude = pesquisa[0].geometry['location']['lng']
      @endereco_formatado = pesquisa[0].formatted_address
    else
      @latitude = 0
      @longitude = 0
    end    
  end
  
  def endereco(terceiro)
    return '' unless terceiro['enderecos']

    endereco = terceiro['enderecos'][0]['tipo'].to_s + " "
    endereco += terceiro['enderecos'][0]['logradouro'].to_s + ", "
    endereco += terceiro['enderecos'][0]['numero'].to_s + ", "
    endereco += terceiro['enderecos'][0]['bairro'].to_s + ', '
    endereco += terceiro['enderecos'][0]['cidade'].to_s + ', '
    endereco += terceiro['enderecos'][0]['siglaEstado'].to_s + ', '
    endereco += terceiro['enderecos'][0]['pais'].to_s

    return endereco
  end
end
