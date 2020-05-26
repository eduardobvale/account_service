class AuthenticateUser
  prepend SimpleCommand

  def initialize(cpf)
    @cpf = cpf
  end

  def call
    JsonWebToken.encode(account_id: account.id) if account
  end

  private

  attr_accessor :cpf

  def account
    Account.find_or_create_by(cpf: cpf)
  end
end