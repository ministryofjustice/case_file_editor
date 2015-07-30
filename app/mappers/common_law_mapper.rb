class CommonLawMapper < Yaks::Mapper
  attributes \
    :reporting_officer_signature_date
  has_one :reporting_officer
end
