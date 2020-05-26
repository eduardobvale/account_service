module Helpers
  module Authentication

    def get_authentication_headers(cpf)
      account = Account.find_or_create_by!(cpf: cpf)
      {
        "ACCEPT" => "application/json",
        "Authorization" => "Bearer #{get_access_token(account)}"
      }
    end

    def get_access_token(account)
      command = AuthenticateUser.call(account.cpf)
      command.result
    end
  end
end