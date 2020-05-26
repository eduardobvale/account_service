class AccountsController < ApplicationController
  before_action :authenticate_request

  def update
    if @current_account.update(accounts_params)
      render :json => { status: @current_account.status, referral_code: @current_account.referral_code }
    else
      render :json => @current_account.errors.full_messages.to_json, status: :unprocessable_entity
    end
  end

  def referrals
    render json: @current_account
  end


  private

  def accounts_params
    params.fetch(:account).permit(:name, :email, :birth_date, :gender, :city, :state, :country)
  end
end