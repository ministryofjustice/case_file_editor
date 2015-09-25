class DefendantExporter < GenericExporter
  attributes \
    :defendant_id,
    :name,
    :date_of_birth,
    :arrest,
    :conditional_caution_considered,
    :cc_not_suitable_reasons,
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
    :breach_order_title,
    :breach_order_title_other,
    :breach_order_lapse_date,
    :remand_application,
    :breach_of_bail,
    :pnc_check_performed,
    :pnc_convictions,
    :court_order_applications,
    :interpreter_required,
    :interpreter_language_or_dialect,
    :notice_to_provide_bad_character_evidence,
    :bad_character_details,
    :dealt_with_in_welsh,
    :person_remand_status,
    :given_charges,
    :initiation_type,
    :signed_charge_sheet,
    :date_sent,
    :parent_guardian_copy,
    :parent_guardian_date_sent,
    :bail_conditions_provided,
    :signed_for_bail,
    :bail_conditions,
    :interview,
    :domestic_violence,
    :first_hearing_datetime,
    :first_hearing_location

  def export
    super.merge(
      'multimedia_evidence_response' =>
        exporter(multimedia_evidence_response).export
    )
  end

  def multimedia_evidence_response
    if object.multimedia_evidence_recorded_responses.any?
      object.multimedia_evidence_recorded_responses
    else
      object.multimedia_evidence_not_recorded_response
    end
  end
end
