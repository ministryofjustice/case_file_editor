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
    presence: {
      message: 'must be present when initiation type is ‘charge’'
    },
    if: :initiated_as_charge?

  attribute :conditional_caution_considered, Virtus::Attribute::Boolean
  validates :conditional_caution_considered, truth: true

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

  attribute :class_a_drug_test_provided, Virtus::Attribute::Boolean
  validates :class_a_drug_test_provided, boolean_presence: true

  attribute :class_a_drug_test_details, String
  validates :class_a_drug_test_details,
    presence: {
      message: 'must be present when a Class A drug test is provided'
    },
    if: :class_a_drug_test_provided
  validates :class_a_drug_test_details,
    absence: {
      message: 'must be absent unless a Class A drug test is provided'
    },
    unless: :class_a_drug_test_provided

  attribute :accepts_drugs_result, Virtus::Attribute::Boolean
  validates :accepts_drugs_result,
    boolean_presence: {
      message: 'must be present when a Class A drug test is provided'
    },
    if: :class_a_drug_test_provided
  validates :accepts_drugs_result,
    boolean_absence: {
      message: 'must be absent unless a Class A drug test is provided'
    },
    unless: :class_a_drug_test_provided

  attribute :has_eec_passports, Virtus::Attribute::Boolean
  validates :has_eec_passports, boolean_presence: true

  attribute :eec_check_submitted, Virtus::Attribute::Boolean
  validates :eec_check_submitted,
    boolean_presence: {
      message: 'must be present if defendant has EEC passports'
    },
    if: :has_eec_passports
  validates :eec_check_submitted,
    boolean_absence: {
      message: 'must be absent unless defendant has EEC passports'
    },
    unless: :has_eec_passports

  attribute :eec_convictions_record_received, Virtus::Attribute::Boolean
  validates :eec_convictions_record_received,
    boolean_presence: {
      message: 'must be present if defendant has EEC passports'
    },
    if: :has_eec_passports
  validates :eec_convictions_record_received,
    boolean_absence: {
      message: 'must be absent unless defendant has EEC passports'
    },
    unless: :has_eec_passports

  attribute :foreign_national_offender, Virtus::Attribute::Boolean
  validates :foreign_national_offender, boolean_presence: true

  attribute :breach_of_order, Virtus::Attribute::Boolean
  validates :breach_of_order, boolean_presence: true

  attribute :breach_order_date_issued, Date
  validates :breach_order_date_issued,
    presence: {
      message: 'must be present if there is a breach of order'
    },
    if: :breach_of_order
  validates :breach_order_date_issued,
    absence: {
      message: 'must be absent unless there is a breach of order'
    },
    unless: :breach_of_order

  attribute :breach_order_court_issued, OrganisationLocation
  validates :breach_order_court_issued,
    presence: {
      message: 'must be present if there is a breach of order'
    },
    if: :breach_of_order
  validates :breach_order_court_issued,
    absence: {
      message: 'must be absent unless there is a breach of order'
    },
    unless: :breach_of_order

  attribute :breach_order_title, String
  validates :breach_order_title,
    inclusion: {
      in: Enumerations::CourtOrderTitle,
      message: 'must be a court order title if there is a breach of order'
    },
    if: :breach_of_order
  validates :breach_order_title,
    absence: {
      message: 'must be absent unless there is a breach of order'
    },
    unless: :breach_of_order

  attribute :breach_order_title_other, String
  validates :breach_order_title_other,
    presence: {
      message: 'must be present if breach order title is ‘other’'
    },
    if: :breach_order_title_needed?

  attribute :breach_order_lapse_date, Date
  validates :breach_order_lapse_date,
    presence: {
      message: 'must be present if there is a breach of order'
    },
    if: :breach_of_order
  validates :breach_order_lapse_date,
    absence: {
      message: 'must be absent unless there is a breach of order'
    },
    unless: :breach_of_order

  attribute :remand_application, RemandApplication

  attribute :breach_of_bail, BreachOfBail

  attribute :pnc_check_performed, Virtus::Attribute::Boolean
  validates :pnc_check_performed, boolean_presence: true

  attribute :pnc_convictions, Virtus::Attribute::Boolean
  validates :pnc_convictions,
    boolean_presence: {
      message: 'must be present if a PNC check was performed'
    },
    if: :pnc_check_performed
  validates :pnc_convictions,
    boolean_absence: {
      message: 'must be absent unless a PNC check was performed'
    },
    unless: :pnc_check_performed

  attribute :court_order_applications, Array[CourtOrder]
  validates :court_order_applications, length: { minimum: 1 }

  attribute :interpreter_required, Virtus::Attribute::Boolean
  validates :interpreter_required, boolean_presence: true

  attribute :interpreter_language_or_dialect, String
  validates :interpreter_language_or_dialect,
    presence: {
      message: 'must be present if an interpreter is required'
    },
    if: :interpreter_required

  attribute :multimedia_evidence_recorded_responses, [MmeRecordedResponse]
  validates :multimedia_evidence_recorded_responses,
    length: {
      minimum: 1,
      message: 'at least one must be provided unless there is a not recorded response'
    },
    unless: :multimedia_evidence_not_recorded_response
  validates :multimedia_evidence_recorded_responses,
    array_uniqueness: true

  attribute :multimedia_evidence_not_recorded_response, MmeNotRecordedResponse
  validates :multimedia_evidence_not_recorded_response,
    presence: {
      message: 'must be provided unless there are recorded responses'
    },
    unless: :mme_recorded_responses_present?

  attribute :notice_to_provide_bad_character_evidence, Virtus::Attribute::Boolean
  validates :notice_to_provide_bad_character_evidence,
    boolean_presence: {
      message: 'must be present if there is an anticipated guilty plea'
    },
    if: :anticipated_guilty_plea?
  validates :notice_to_provide_bad_character_evidence,
    boolean_absence: {
      message: 'must be absent if there is no anticipated guilty plea'
    },
    unless: :anticipated_guilty_plea?

  attribute :bad_character_details, String
  validates :bad_character_details,
    presence: {
      message: 'must be present if there is a notice to provide bad character evidence'
    },
    if: :notice_to_provide_bad_character_evidence
  validates :bad_character_details,
    absence: {
      message: 'must be absent unless there is a notice to provide bad character evidence'
    },
    unless: :notice_to_provide_bad_character_evidence

  attribute :dealt_with_in_welsh, Virtus::Attribute::Boolean
  validates :dealt_with_in_welsh, boolean_presence: true

  attribute :person_remand_status, String
  validates :person_remand_status,
    inclusion: { in: Enumerations::PersonRemandStatus }

  attribute :given_charges, Virtus::Attribute::Boolean
  validates :given_charges, boolean_presence: true

  attribute :initiation_type, String
  validates :initiation_type,
    inclusion: { in: Enumerations::InitiationType }

  attribute :signed_charge_sheet, Virtus::Attribute::Boolean
  validates :signed_charge_sheet,
    boolean_presence: {
      message: 'must be present when initiation type is ‘charge’'
    },
    if: :initiated_as_charge?
  validates :signed_charge_sheet,
    boolean_absence: {
      message: 'must be absent unless initiation type is ‘charge’'
    },
    unless: :initiated_as_charge?

  attribute :date_sent, Date
  validates :date_sent,
    presence: {
      message: 'must be present when initiation type is ‘requisition’'
    },
    if: :initiated_as_requisition?
  validates :date_sent,
    absence: {
      message: 'must be absent unless initiation type is ‘requisition’'
    },
    unless: :initiated_as_requisition?

  attribute :parent_guardian_copy, Virtus::Attribute::Boolean
  # TODO: validate present iff under 18 (TBD)

  attribute :parent_gardian_date_sent, Date
  validates :parent_gardian_date_sent,
    presence: {
      message: 'must be present if there is a parent/guardian copy'
    },
    if: :parent_guardian_copy
  # TODO: validate present iff under 18 (TBD)

  attribute :bail_conditions_provided, Virtus::Attribute::Boolean
  validates :bail_conditions_provided,
    boolean_presence: {
      message: 'must be present if bail is conditional'
    },
    if: :conditional_bail?
  validates :bail_conditions_provided,
    boolean_absence: {
      message: 'must be absent if bail is unconditional'
    },
    unless: :conditional_bail?

  attribute :signed_for_bail, Virtus::Attribute::Boolean
  validates :signed_for_bail,
    boolean_presence: {
      message: 'must be present if bail is unconditional'
    },
    if: :unconditional_bail?
  validates :signed_for_bail,
    boolean_absence: {
      message: 'must be absent if bail is conditional'
    },
    unless: :unconditional_bail?

  attribute :bail_conditions, Array[BailCondition]
  validates :bail_conditions,
    length: {
      minimum: 1,
      message: 'at least one must be present if bail is conditional'
    },
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

  def anticipated_guilty_plea?
    offences.any?(&:anticipated_guilty_plea?)
  end
end
