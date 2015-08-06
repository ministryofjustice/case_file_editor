class CommonLaw
  include Virtus.model
  include ActiveModel::Validations

  attribute :reporting_officer, PersonName
  validates :reporting_officer, presence: true

  attribute :reporting_officer_signature_date, Date
  validates :reporting_officer_signature_date, presence: true
end
