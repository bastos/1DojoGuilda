#encoding: utf-8

require '../password_strength_checker'

describe PasswordStrengthChecker do
  context "somente letras" do
    it "deve ser verdadeiro caso a senha tenha só letras" do
      password = "askdhsaidh"
      PasswordStrengthChecker.new(password).somente_letras?.should be_true
    end
    
    it "deve ser false caso a senha tenha só letras e números" do
      password = "a213skdhsaidh"
      PasswordStrengthChecker.new(password).somente_letras?.should be_false
    end    
  end
  
  context "somente numeros" do
    it "deve conter numeros" do
        password = "1234"
        PasswordStrengthChecker.new(password).somente_numeros?.should be_true
    end
    it "deve ser falso quando nao tiver numeros" do
        password = "abdcd"
        PasswordStrengthChecker.new(password).somente_numeros?.should be_false
    end
  end
  
  context "letras e numeros" do
    it "deve ser verdadeiro quando existir letras e numeros" do
      password = "abdcd1234"
      PasswordStrengthChecker.new(password).letras_e_numeros?.should be_true

      password = "1234adbc"
      PasswordStrengthChecker.new(password).letras_e_numeros?.should be_true
    end
    
    it "deve ser false quando nao existir letras e numeros" do
      password = "!!!"
      PasswordStrengthChecker.new(password).letras_e_numeros?.should be_false
    end
  end
  
  context "conter letras" do
    it "deve ser verdadeiro quando existir letras" do
      password = "a123456"
      PasswordStrengthChecker.new(password).contem_letras?.should be_true
    end
    
    it "deve ser false quando nao existir letras" do
      password = "123456"
      PasswordStrengthChecker.new(password).contem_letras?.should be_false
    end
    
    it "maiusculas e minusculas" do
      PasswordStrengthChecker.new("adefEG").contem_maiusculas_minusculas?.should be_true
    end
    
    it "sem maiusculas" do
      PasswordStrengthChecker.new("agfs").contem_maiusculas_minusculas?.should be_false
    end
  end
  
  context "contem numeros" do
    it "deve ser verdadeiro quando contem numeros" do
      password = "a123456b"
      PasswordStrengthChecker.new(password).contem_numeros?.should be_true
    end
    
    it "deve ser false quando nao contem numeros" do
      password = "abs"
      PasswordStrengthChecker.new(password).contem_numeros?.should be_false
    end    
  end
  
  context "contem caracteres especiais" do 
    it "deve ser verdadeiro quando contem caracteres especiais" do
      password = "asb123%"
      PasswordStrengthChecker.new(password).contem_caracteres_especiais?.should be_true
    end
    
    it "deve ser false quando nao contem caracteres especiais" do
      password = "abs123"
      PasswordStrengthChecker.new(password).contem_caracteres_especiais?.should be_false
    end    
  end
  
  it "Senha apenas com letras eh muito fraca" do
    PasswordStrengthChecker.new('adg').classificacao.should == :muito_fraca
  end
  
  it "Senha com letras maiusculas e minusculas eh muito fraca" do
    PasswordStrengthChecker.new('adgADG').classificacao.should == :muito_fraca
  end
  
  it "Senha vazia deve ser muito fraca" do
    PasswordStrengthChecker.new('').classificacao.should == :muito_fraca
  end
  
  it "Senha com somente numeros maior de 6 caracteres deve ser muito fraca" do
    PasswordStrengthChecker.new("1100000").classificacao.should == :muito_fraca
  end
  
  it "Senha com letras, numeros e caracteres especiais com tamanho maior do que 12 deve ser boa" do
    PasswordStrengthChecker.new("ahkl479@%&*qry").classificacao.should == :boa
  end
  
  it "Senha com letras e numeros sem repeticao e sem sequencia." do
    PasswordStrengthChecker.new("afg246").classificacao.should == :muito_fraca
  end  
  
  it "Senha 1w2e3ghj153djewr82 deve ser regular" do
    PasswordStrengthChecker.new("1w2e3ghj153djewr82a").classificacao.should == :regular
  end
  
  it "Senha com letras, numeros e caracteres especiais com tamanho maior do que 18 deve ser muito boa" do
    pass = PasswordStrengthChecker.new("1w2e3ghj153dJeWr82ahkl479@%&*qry")
    pass.check_score
    #puts "=== #{pass.score}"
    pass.classificacao.should == :muito_boa
    
  end
end