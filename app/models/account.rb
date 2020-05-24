class Account < ApplicationRecord
  validates_cpf_format_of :cpf
  validates_email_format_of :email, if: proc { |record| record.email.present? }
  validates :referral_code, uniqueness: true, if: proc { |record| record.referral_code.present? }
  validates :cpf, presence: true, uniqueness: true
  validates :gender, inclusion: { 
    in: ['Male', 'Female', 'Prefer not to answer'],
    message: "%{value} is not a valid option", 
    if: proc { |record| record.gender.present? } 
  }
  before_validation :clear_cpf_string
  before_save :set_status, :set_referral_code

  enum status: {
    pending: 0,
    complete: 1
  }

  def set_referral_code
    if required_fields_are_set? && referral_code.blank?
      loop do
        self.referral_code = 8.times.map{rand(10)}.join
        break unless self.class.exists?(referral_code: referral_code)
      end
    end
  end


  private
  def required_fields_are_set?
    ['name','email','cpf','birth_date','gender','city','state','country'].all? {|field| self.read_attribute(field).present? }
  end

  def set_status
    if required_fields_are_set?
      self.status = :complete 
    else
      self.status = :pending
    end
  end

  def clear_cpf_string
    self.cpf = cpf.gsub(/[^0-9]/, "") if attribute_present?("cpf")
  end
end