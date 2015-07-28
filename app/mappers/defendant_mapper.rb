class DefendantMapper < Yaks::Mapper
  attributes \
    :defendant_id,
    :name,
    :date_of_birth,
    :arrest,
    :conditional_caution_considered,
    :offences,
    :occupation,
    :class_a_drug_test_provided,
    :class_a_drug_test_details,
    :accepts_drugs_result,
    :has_eec_passports,
    :eec_check_submitted,
    :eec_convictions_record_received,
    :foreign_national_offender,
    :breach_of_order,
    :breach_order_date_issued,
    :breach_order_court_issued,
    :breach_order_title_other,
    :breach_order_lapse_date,
    :remand_application,
    :breach_of_bail,
    :pnc_check_performed,
    :pnc_convictions,
    :court_order_applications,
    :interpreter_required,
    :interpreter_language_or_dialect,
    :multimedia_evidence_response,
    :notice_to_provide_bad_character_evidence,
    :bad_character_details,
    :dealt_with_in_welsh,
    :person_remand_status,
    :given_charges,
    :signed_charge_sheet,
    :date_sent,
    :parent_guardian_copy,
    :parent_gardian_date_sent,
    :bail_conditions_provided,
    :signed_for_bail,
    :bail_conditions,
    :interview,
    :domestic_violence,
    :first_hearing_datetime,
    :first_hearing_location

  attribute :cc_not_suitable_reasons do
    object.cc_not_suitable_reasons.value
  end

  attribute :breach_order_title do
    object.breach_order_title.value
  end

  attribute :initiation_type do
    object.initiation_type.value
  end
end
