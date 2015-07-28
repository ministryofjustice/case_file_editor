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
    :property_ids,
    :interview_extension

  attribute :cjs_offence_code do
    object.cjs_offence_code.value
  end
end
