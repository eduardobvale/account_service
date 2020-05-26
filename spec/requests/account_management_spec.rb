require "rails_helper"
require "ffaker"
RSpec.describe "Account management", :type => :request do

  describe "put /account" do

    subject(:cpf) { FFaker::IdentificationBR.cpf }
    subject(:headers) { get_authentication_headers(cpf) }
      
    context "When not all fields are set" do
      it "returns a success code and pending status" do
        put "/account", :params => { :account => {:name => "Test"} }, :headers => headers

        response_json = JSON.parse(response.body)
        expect(response_json["status"]).to eq("pending")
        expect(response).to have_http_status(:ok)
      end
    end

    context "When any input is invalid" do
      it "returns an error code" do
        put "/account", :params => { :account => {:email => "invalidemail.com"} }, :headers => headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "When all fields are set" do
      it "returns a success code, status complete and referral_code" do
        put "/account", :params => { :account => {
          :name => FFaker::Internet.email,
          :email => FFaker::Internet.email,
          :birth_date => FFaker::Time.date,
          :gender => FFaker::Gender.binary.capitalize,
          :city => FFaker::AddressUS.city,
          :state => FFaker::AddressUS.state,
          :country => FFaker::AddressUS.country
        } }, :headers => headers
        
        response_json = JSON.parse(response.body)
        expect(response_json["status"]).to eq("complete")
        expect(response_json["referral_code"]).not_to be_blank
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "get /account/referrals" do

    it "returns a success code" do
        cpf = FFaker::IdentificationBR.cpf
        headers = get_authentication_headers(cpf)
        
        first_account = Account.where(cpf: cpf).first

        first_account.update(
          name: FFaker::Internet.email,
          email: FFaker::Internet.email,
          birth_date: FFaker::Time.date,
          gender: FFaker::Gender.binary.capitalize,
          city: FFaker::AddressUS.city,
          state: FFaker::AddressUS.state,
          country: FFaker::AddressUS.country)


        second_account = Account.create!(
          cpf: FFaker::IdentificationBR.cpf,
          name: FFaker::Internet.email,
          email: FFaker::Internet.email,
          birth_date: FFaker::Time.date,
          gender: FFaker::Gender.binary.capitalize,
          city: FFaker::AddressUS.city,
          state: FFaker::AddressUS.state,
          country: FFaker::AddressUS.country,
          referrer_code: first_account.referral_code)


      get "/account/referrals", :headers => headers

      response_json = JSON.parse(response.body)
      expect(response_json.map{|account| account["id"]}).to include(second_account.id)
      expect(response).to have_http_status(:ok)
    end
  end
end