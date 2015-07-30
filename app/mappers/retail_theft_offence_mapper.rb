class RetailTheftOffenceMapper < Yaks::Mapper
  attributes \
    :date,
    :type,
    :from_date,
    :to_date,
    :offence_title,
    :charge_wording,
    :reply_to_charge,
    :points_to_prove_met_by,
    :demeanour_at_incident,
    :anticipated_plea,
    :committed_on_bail,
    :children_present,
    :ages_of_children,
    :cjs_offence_code,
    :property_ids
  has_one :interview_extension
end
