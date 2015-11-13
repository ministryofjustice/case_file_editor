class CommonLaw
  include BasicModel

  attribute :reporting_officer, OfficerName
  validates :reporting_officer, presence: true

  attribute :reporting_officer_signature_date, Date
  validates :reporting_officer_signature_date, presence: true
end
