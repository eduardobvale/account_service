class AuthenticateUser
  prepend SimpleCommand

  def initialize(cpf)
    @cpf = cpf
  end

  def call
    if account
      JsonWebToken.encode(account_id: account.id) 
    else
      errors.add(:cpf, 'is not a valid CPF')
    end
  end

  private

  attr_accessor :cpf

  def account
    if CPF.valid?(cpf)
      Account.find_or_create_by!(cpf: cpf)
    end
  end
end