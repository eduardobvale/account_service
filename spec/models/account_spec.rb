require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#cpf' do
    it { is_expected.to validate_presence_of(:cpf) } 

    it 'validates cpf format' do
      record = Account.new
      record.cpf = '307'

      record.valid?

      expect(record.errors[:cpf]).to include('is not a valid CPF')
    end

    it 'strip any char but digits from cpf before validation' do
      record = Account.new
      
      record.cpf = '307.578.490-75'
      record.valid?

      expect(record.cpf).to eq '30757849075'
    end
  end

  describe '#gender' do
    it { is_expected.to allow_value('Male').for(:gender) }
    it { is_expected.to allow_value('Female').for(:gender) }
    it { is_expected.to allow_value('Prefer not to answer').for(:gender) }

    it 'validates gender format' do
      record = Account.new
      record.gender = 'Test'

      record.valid?

      expect(record.errors[:gender]).to include('Test is not a valid option')
    end
  end

   describe '#email' do
    it 'validates email format' do
      record = Account.new
      record.email = 'Test'

      record.valid?

      expect(record.errors[:email]).to include('is not a valid address')
    end
  end
  
  describe '#save' do
    context 'when all fields are set and valid' do
      subject(:record) do
        record = Account.new(
          name: 'Jane Doe',
          email: 'janedoe@example.com',
          cpf: '307.578.490-75',
          birth_date: Time.now,
          gender: 'Female',
          city: 'Pittsburgh',
          state: 'Pennsylvania',
          country: 'United States')
        record.save!
        record
      end

      it 'sets status as complete' do
        expect(record.status).to eq "complete"
      end

      it 'generates a referral code' do
        expect(record.referral_code).not_to be_nil
        expect(record.referral_code.length).to eq 8
      end
    end

    context 'when some fields are set' do
      it 'sets status as pending' do
        record = Account.new(cpf: '307.578.490-75')
        record.save!
        expect(record.status).to eq "pending"
      end
    end
  end
end