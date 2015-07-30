class DefendantMapper < Yaks::Mapper
  attributes \
    :defendant_id,
    :date_of_birth,
    :conditional_caution_considered,
    :cc_not_suitable_reasons,
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
    :breach_order_title,
    :breach_order_title_other,
    :breach_order_lapse_date,
    :pnc_check_performed,
    :pnc_convictions,
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
    :parent_gardian_date_sent,
    :bail_conditions_provided,
    :signed_for_bail,
    :first_hearing_datetime
  has_one :name
  has_one :arrest
  has_many :offences
  has_one :breach_order_court_issued
  has_one :remand_application
  has_one :breach_of_bail
  has_many :court_order_applications
  has_many :bail_conditions
  has_one :interview
  has_one :domestic_violence
  has_one :first_hearing_location
end
