require_dependency 'enumerations/c_c_not_suitable_reason'

class Defendant
  include Virtus.model
  include ActiveModel::Validations

  attribute :defendant_id, String

  attribute :name, PersonName
  validates :name, presence: true

  attribute :date_of_birth, Date
  validates :date_of_birth, presence: true

  attribute :arrest, Arrest
  validates :arrest,
    presence: true,
    if: :initiated_as_charge?

  attribute :conditional_caution_considered, Boolean
  validates :conditional_caution_considered, inclusion: { in: [true] }

  attribute :cc_not_suitable_reasons, Array[String]
  validates :cc_not_suitable_reasons,
    array_inclusion: { in: Enumerations::CCNotSuitableReason },
    array_uniqueness: true,
    length: { minimum: 1 }

  attribute :offences, Array[OffenceCollection]
  validates :offences,
    array_uniqueness: true,
    length: { minimum: 1 }

  attribute :occupation, String
  validates :occupation, presence: true

  attribute :class_a_drug_test_provided, Boolean
  validates :class_a_drug_test_provided, inclusion: { in: [true, false] }

  attribute :class_a_drug_test_details, String
  validates :class_a_drug_test_details,
    presence: true,
    if: :class_a_drug_test_provided
  validates :class_a_drug_test_details,
    absence: true,
    unless: :class_a_drug_test_provided

  attribute :accepts_drugs_result, Boolean
  validates :accepts_drugs_result,
    inclusion: { in: [true, false] },
    if: :class_a_drug_test_provided
  validates :accepts_drugs_result,
    inclusion: { in: [nil] },
    unless: :class_a_drug_test_provided

  attribute :has_eec_passports, Boolean
  validates :has_eec_passports, inclusion: { in: [true, false] }

  attribute :eec_check_submitted, Boolean
  validates :eec_check_submitted,
    inclusion: { in: [true, false] },
    if: :has_eec_passports
  validates :eec_check_submitted,
    inclusion: { in: [nil] },
    unless: :has_eec_passports

  attribute :eec_convictions_record_received, Boolean
  validates :eec_convictions_record_received,
    inclusion: { in: [true, false] },
    if: :has_eec_passports
  validates :eec_convictions_record_received,
    inclusion: { in: [nil] },
    unless: :has_eec_passports

  attribute :foreign_national_offender, Boolean
  validates :foreign_national_offender, inclusion: { in: [true, false] }

  attribute :breach_of_order, Boolean
  validates :breach_of_order, inclusion: { in: [true, false] }

  attribute :breach_order_date_issued, Date
  validates :breach_order_date_issued,
    presence: true,
    if: :breach_of_order
  validates :breach_order_date_issued,
    absence: true,
    unless: :breach_of_order

  attribute :breach_order_court_issued, OrganisationLocation
  validates :breach_order_court_issued,
    presence: true,
    if: :breach_of_order
  validates :breach_order_court_issued,
    absence: true,
    unless: :breach_of_order

  attribute :breach_order_title, String
  validates :breach_order_title,
    inclusion: { in: Enumerations::CourtOrderTitle },
    if: :breach_of_order
  validates :breach_order_title,
    absence: true,
    unless: :breach_of_order

  attribute :breach_order_title_other, String
  validates :breach_order_title_other,
    presence: true,
    if: :breach_order_title_needed?

  attribute :breach_order_lapse_date, Date
  validates :breach_order_lapse_date,
    presence: true,
    if: :breach_of_order
  validates :breach_order_lapse_date,
    absence: true,
    unless: :breach_of_order

  attribute :remand_application, RemandApplication

  attribute :breach_of_bail, BreachOfBail

  attribute :pnc_check_performed, Boolean
  validates :pnc_check_performed, inclusion: { in: [true, false] }

  attribute :pnc_convictions, Boolean
  validates :pnc_convictions,
    inclusion: { in: [true, false] },
    if: :pnc_check_performed
  validates :pnc_convictions,
    inclusion: { in: [nil] },
    unless: :pnc_check_performed

  attribute :court_order_applications, Array[CourtOrder]
  validates :court_order_applications, length: { minimum: 1 }

  attribute :interpreter_required, Boolean
  validates :interpreter_required, inclusion: { in: [true, false] }

  attribute :interpreter_language_or_dialect, String
  validates :interpreter_language_or_dialect,
    presence: true,
    if: :interpreter_required

  attribute :multimedia_evidence_recorded_responses, [MmeRecordedResponse]
  validates :multimedia_evidence_recorded_responses,
    length: { minimum: 1 },
    array_uniqueness: true,
    unless: :multimedia_evidence_not_recorded_response

  attribute :multimedia_evidence_not_recorded_response, MmeNotRecordedResponse
  validates :multimedia_evidence_not_recorded_response,
    presence: true,
    unless: :mme_recorded_responses_present?

  attribute :notice_to_provide_bad_character_evidence, Boolean
  # TODO: validate only if there is at least one anticipated not guilty plea

  attribute :bad_character_details, String
  validates :bad_character_details,
    presence: true,
    if: :notice_to_provide_bad_character_evidence
  validates :bad_character_details,
    absence: true,
    unless: :notice_to_provide_bad_character_evidence

  attribute :dealt_with_in_welsh, Boolean
  validates :dealt_with_in_welsh, inclusion: { in: [true, false] }

  attribute :person_remand_status, String
  validates :person_remand_status,
    inclusion: { in: Enumerations::PersonRemandStatus }

  attribute :given_charges, Boolean
  validates :given_charges, inclusion: { in: [true, false] }

  attribute :initiation_type, String
  validates :initiation_type,
    inclusion: { in: Enumerations::InitiationType }

  attribute :signed_charge_sheet, Boolean
  validates :signed_charge_sheet,
    inclusion: { in: [true, false] },
    if: :initiated_as_charge?
  validates :signed_charge_sheet,
    inclusion: { in: [nil] },
    unless: :initiated_as_charge?

  attribute :date_sent, Date
  validates :date_sent,
    presence: true,
    if: :initiated_as_requisition?
  validates :date_sent,
    absence: true,
    unless: :initiated_as_requisition?

  attribute :parent_guardian_copy, Boolean
  # TODO: validate present iff under 18 (TBD)

  attribute :parent_gardian_date_sent, Date
  validates :parent_gardian_date_sent,
    presence: true,
    if: :parent_guardian_copy
  # TODO: validate present iff under 18 (TBD)

  attribute :bail_conditions_provided, Boolean
  validates :bail_conditions_provided,
    inclusion: { in: [true, false] },
    if: :conditional_bail?
  validates :bail_conditions_provided,
    inclusion: { in: [nil] },
    unless: :conditional_bail?

  attribute :signed_for_bail, Boolean
  validates :signed_for_bail,
    inclusion: { in: [true, false] },
    if: :unconditional_bail?
  validates :signed_for_bail,
    inclusion: { in: [nil] },
    unless: :unconditional_bail?

  attribute :bail_conditions, Array[BailCondition]
  validates :bail_conditions,
    length: { minimum: 1 },
    if: :conditional_bail?

  attribute :interview, Interview
  validates :interview, presence: true

  attribute :domestic_violence, Array[DomesticViolence]
  # TODO: validate length >= 1 if case is domestic violence

  attribute :first_hearing_datetime, DateTime
  validates :first_hearing_datetime, presence: true

  attribute :first_hearing_location, OrganisationLocation
  validates :first_hearing_location, presence: true

  def breach_order_title_needed?
    breach_order_title == 'other'
  end

  def mme_recorded_responses_present?
    multimedia_evidence_recorded_responses.any?
  end

  def initiated_as_charge?
    initiation_type == 'charge'
  end

  def initiated_as_requisition?
    initiation_type == 'requisition'
  end

  def conditional_bail?
    person_remand_status == 'conditional_bail'
  end

  def unconditional_bail?
    person_remand_status == 'unconditional_bail'
  end
end
