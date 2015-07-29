require_dependency 'enumerations/c_c_not_suitable_reason'

class Defendant
  include Virtus.model
  include ActiveModel::Validations

  attribute :defendant_id, String
  attribute :name, PersonName
  attribute :date_of_birth, Date
  attribute :arrest, Arrest
  attribute :conditional_caution_considered, Boolean
  attribute :cc_not_suitable_reasons, Array[String]
  validates :cc_not_suitable_reasons,
    array_inclusion: { in: Enumerations::CCNotSuitableReason }
  attribute :offences, Array[OffenceCollection]
  attribute :occupation, String
  attribute :class_a_drug_test_provided, Boolean
  attribute :class_a_drug_test_details, String
  attribute :accepts_drugs_result, Boolean
  attribute :has_eec_passports, Boolean
  attribute :eec_check_submitted, Boolean
  attribute :eec_convictions_record_received, Boolean
  attribute :foreign_national_offender, Boolean
  attribute :breach_of_order, Boolean
  attribute :breach_order_date_issued, Date
  attribute :breach_order_court_issued, OrganisationLocation
  attribute :breach_order_title, String
  validates :breach_order_title,
    inclusion: { in: Enumerations::CourtOrderTitle }
  attribute :breach_order_title_other, String
  attribute :breach_order_lapse_date, Date
  attribute :remand_application, RemandApplication
  attribute :breach_of_bail, BreachOfBail
  attribute :pnc_check_performed, Boolean
  attribute :pnc_convictions, Boolean
  attribute :court_order_applications, Array[CourtOrder]
  attribute :interpreter_required, Boolean
  attribute :interpreter_language_or_dialect, String
  # attribute :multimedia_evidence_response, MmeResponse
  # TODO: make this work with the weird union type
  attribute :notice_to_provide_bad_character_evidence, Boolean
  attribute :bad_character_details, String
  attribute :dealt_with_in_welsh, String
  attribute :person_remand_status, String
  attribute :given_charges, Boolean
  attribute :initiation_type, String
  validates :initiation_type,
    inclusion: { in: Enumerations::InitiationType }
  attribute :signed_charge_sheet, Boolean
  attribute :date_sent, Date
  attribute :parent_guardian_copy, Boolean
  attribute :parent_gardian_date_sent, Date
  attribute :bail_conditions_provided, Boolean
  attribute :signed_for_bail, Boolean
  attribute :bail_conditions, Array[BailCondition]
  attribute :interview, StandardInterview
  attribute :domestic_violence, DomesticViolence
  attribute :first_hearing_datetime, DateTime
  attribute :first_hearing_location, OrganisationLocation
end
