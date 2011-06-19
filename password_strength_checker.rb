class PasswordStrengthChecker
  attr_reader :score
  
  DEFAULT_SCORE = -80
  
  MUITO_FRACA = -1000..-65
  FRACA = -64..-48
  REGULAR = -47..-32
  BOA = -31..-16
  MUITO_BOA = -15..1000

  def initialize(pwd)
    @pwd = pwd
    @score = DEFAULT_SCORE
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
  
  def contem_maiusculas_minusculas?
    @pwd =~ /[a-z]+/ and @pwd =~ /[A-Z]+/
  end
  
  def contem_numeros?
    @pwd =~/[0-9]/
  end
  
  def contem_caracteres_especiais?
    @pwd =~/[^\d\w]+/
  end


  
  def classificacao
    check_score
    
    if MUITO_FRACA.include? @score
      :muito_fraca
    elsif FRACA.include? @score
      :fraca
    elsif REGULAR.include? @score
      :regular
    elsif BOA.include? @score
      :boa
    elsif MUITO_BOA.include? @score
      :muito_boa
    end
  end
  
  def check_score
    @score -= 10 if somente_letras?
    @score += 10 if contem_numeros?
    @score -= 10 if somente_numeros?
    @score += 20 if contem_caracteres_especiais?
    @score += obter_pontos_por_tamanho
 
  end
  
  def obter_pontos_por_tamanho
    if @pwd.size > 18
      30
    elsif  @pwd.size > 12
      20
    elsif  @pwd.size > 6
      10
    else
      0
    end
  end
end