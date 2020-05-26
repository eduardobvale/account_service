class AccountsController < ApplicationController
  before_action :authenticate_request

  def update
    if @current_account.update(accounts_params)
      render :update, status: :ok
    else
      render :json => @current_account.errors.full_messages.to_json, status: :unprocessable_entity
    end
  end

  def referrals
    @referrals = @current_account.referrals
    render :referrals, status: :ok
  end

  private

  def accounts_params
    params.fetch(:account).permit(:name, :email, :birth_date, :gender, :city, :state, :country, :referrer_code)
  end
end