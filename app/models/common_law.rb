class CommonLaw
  include Virtus.model
  include ActiveModel::Validations

  attribute :reporting_officer, PersonName
  attribute :reporting_officer_signature_date, Date
end
