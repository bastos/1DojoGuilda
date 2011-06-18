#encoding: utf-8

require 'rubygems'
require 'rspec'

=begin
10    Maior que 6 caracteres?
20    Maior que 12 caracteres?
30    Maior que 18 caracteres?
10    Contêm números?
20    Contêm caracteres especiais?
20    Contêm letras maiúsculas e minúsculas?

-10    Apenas letras?
-10    Apenas números?
-5    Apenas números e letras?
-10    Repetição de números em sequência?
-10    Repetição de letras em sequência?
-10    Sequencia de letras(abc, def, ...)?
-10    Sequencia de números(123, 456)?

muito_fraco: -65 ou menor
adg, abc, 123, abc169, abc123, adg123, 111, aaa, afg246

fraco: -64 : -48
a1a1a1

medio: -47 : -32
boa: -31 a -16
muito_boa: -15 ou maior


=end
class Password

  def initialize(pwd)
    @pwd = pwd
  end
  
  def somente_letras?
    @pwd =~ /^[a-zA-Z]+$/
  end
  
  def somente_numeros?
    @pwd =~ /^[0-9]+$/
  end
  
  def letras_e_numeros?
    @pwd =~ /[[:alpha]+[0..9]+]+/
  end
  
  def contem_letras?
    @pwd =~/[a-zA-Z]/
  end
  
  def contem_numeros?
    @pwd =~/[0-9]/
  end
  
  def classificacao
    score = -80
    score -= 10 if somente_letras?
    score += 10 if contem_numeros?
    score -= 10 if somente_numeros?
      
    if score <= -80
      :muito_fraca
    elsif score < -60
      :fraco
    elsif score < -40
      :media
    elsif score < -20
      :boa
    else
      :muito_boa
    end
  end
  
end

describe Password do
  before(:each) do
    
  end
  
  it "Senha apenas com letras eh muito fraca" do
    Password.new('adg').classificacao.should == :muito_fraca
  end
  
  it "Senha vazia deve ser muito fraca" do
    Password.new('').classificacao.should == :muito_fraca
  end
  
  it "Senha somente com numeros deve ser muito fraca" do
    Password.new("1100000").classificacao.should == :muito_fraca
  end
  
  it "Senha com letras e numeros sem repeticao e sem sequencia." do
    Password.new("abd145").classificacao.should == :fraco
  end
  
end