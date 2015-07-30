class CommonLawNotForDisclosureMapper < Yaks::Mapper
  attributes \
    :reporting_officer_signature_date,
    :details_of_relevant_unused_material
  has_one :reporting_officer
end
