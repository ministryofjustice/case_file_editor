require_dependency 'enumerations/c_c_not_suitable_reason'

class Defendant
  include BasicModel
  include AgeCalculation
  include Virtus.relations(as: :defendant)
  include CaseTypeSpecific

  ADULT_MIN_AGE = 18

  attribute :defendant_id, String

  attribute :name, PersonName
  validates :name, presence: true

  attribute :date_of_birth, Date
  validates :date_of_birth, presence: true

  attribute :arrest, Arrest
  validates :arrest,
    presence: true,
    if: :initiated_as_charge?

  attribute :conditional_caution_considered, Virtus::Attribute::Boolean
  validates :conditional_caution_considered,
    truth: true,
    if: :first_hearing_case?
  validates :conditional_caution_considered,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :cc_not_suitable_reasons, Array[String]
  validates :cc_not_suitable_reasons,
    array_inclusion: { in: Enumerations::CCNotSuitableReason },
    array_uniqueness: true,
    length: { minimum: 1 },
    if: :first_hearing_case?
  validates :cc_not_suitable_reasons,
    length: { is: 0 },
    if: :breach_of_bail_case?

  attribute :offences, Array[OffenceCollection], relation: true
  validates :offences,
    array_uniqueness: true,
    length: { minimum: 1 },
    if: :first_hearing_case?
  validates :offences,
    length: { is: 0 },
    if: :breach_of_bail_case?

  attribute :occupation, String
  validates :occupation, presence: true

  attribute :class_a_drug_test_provided, Virtus::Attribute::Boolean
  validates :class_a_drug_test_provided,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :class_a_drug_test_details, String
  with_options if: :first_hearing_case? do
    validates :class_a_drug_test_details,
      presence: true,
      if: :class_a_drug_test_provided
    validates :class_a_drug_test_details,
      absence: true,
      unless: :class_a_drug_test_provided
  end
  validates :class_a_drug_test_details,
    absence: true,
    if: :breach_of_bail_case?

  attribute :accepts_drugs_result, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :accepts_drugs_result,
      boolean_presence: true,
      if: :class_a_drug_test_provided
    validates :accepts_drugs_result,
      boolean_absence: true,
      unless: :class_a_drug_test_provided
  end
  validates :accepts_drugs_result,
    absence: true,
    if: :breach_of_bail_case?

  attribute :has_eec_passports, Virtus::Attribute::Boolean
  validates :has_eec_passports,
    boolean_presence: true,
    if: :first_hearing_case?
  validates :has_eec_passports,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :eec_check_submitted, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :eec_check_submitted,
      boolean_presence: true,
      if: :has_eec_passports
    validates :eec_check_submitted,
      boolean_absence: true,
      unless: :has_eec_passports
  end
  validates :eec_check_submitted,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :eec_convictions_record_received, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :eec_convictions_record_received,
      boolean_presence: true,
      if: :has_eec_passports
    validates :eec_convictions_record_received,
      boolean_absence: true,
      unless: :has_eec_passports
  end
  validates :eec_convictions_record_received,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :foreign_national_offender, Virtus::Attribute::Boolean
  validates :foreign_national_offender, boolean_presence: true

  attribute :breach_of_order, Virtus::Attribute::Boolean
  validates :breach_of_order,
    boolean_presence: true,
    if: :first_hearing_case?
  validates :breach_of_order,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :breach_order_date_issued, Date
  with_options if: :first_hearing_case? do
    validates :breach_order_date_issued,
      presence: true,
      if: :breach_of_order
    validates :breach_order_date_issued,
      absence: true,
      unless: :breach_of_order
  end
  validates :breach_order_date_issued,
    absence: true,
    if: :breach_of_bail_case?

  attribute :breach_order_court_issued, OrganisationLocation
  with_options if: :first_hearing_case? do
    validates :breach_order_court_issued,
      presence: true,
      if: :breach_of_order
    validates :breach_order_court_issued,
      absence: true,
      unless: :breach_of_order
  end
  validates :breach_order_court_issued,
    absence: true,
    if: :breach_of_bail_case?

  attribute :breach_order_title, String
  with_options if: :first_hearing_case? do
    validates :breach_order_title,
      inclusion: { in: Enumerations::CourtOrderTitle },
      if: :breach_of_order
    validates :breach_order_title,
      absence: true,
      unless: :breach_of_order
  end
  validates :breach_order_title,
    absence: true,
    if: :breach_of_bail_case?

  attribute :breach_order_title_other, String
  with_options if: :first_hearing_case? do
    validates :breach_order_title_other,
      presence: true,
      if: :breach_order_title_needed?
  end
  validates :breach_order_title_other,
    absence: true,
    if: :breach_of_bail_case?

  attribute :breach_order_lapse_date, Date
  with_options if: :first_hearing_case? do
    validates :breach_order_lapse_date,
      presence: true,
      if: :breach_of_order
    validates :breach_order_lapse_date,
      absence: true,
      unless: :breach_of_order
  end
  validates :breach_order_lapse_date,
    absence: true,
    if: :breach_of_bail_case?

  attribute :remand_application, RemandApplication
  validates :remand_application,
    presence: true,
    if: :breach_of_bail_case?

  attribute :breach_of_bail, BreachOfBail
  validates :breach_of_bail,
    presence: true,
    if: :breach_of_bail_case?

  attribute :pnc_check_performed, Virtus::Attribute::Boolean
  validates :pnc_check_performed, boolean_presence: true

  attribute :pnc_convictions, Virtus::Attribute::Boolean
  validates :pnc_convictions,
    boolean_presence: true,
    if: :pnc_check_performed
  validates :pnc_convictions,
    boolean_absence: true,
    unless: :pnc_check_performed

  attribute :court_order_applications, Array[CourtOrder]
  validates :court_order_applications,
    length: { minimum: 1 },
    if: :first_hearing_case?
  validates :court_order_applications,
    length: { is: 0 },
    if: :breach_of_bail_case?

  attribute :interpreter_required, Virtus::Attribute::Boolean
  validates :interpreter_required, boolean_presence: true

  attribute :interpreter_language_or_dialect, String
  validates :interpreter_language_or_dialect,
    presence: true,
    if: :interpreter_required

  attribute :multimedia_evidence_response, Array[MmeResponse], relation: true
  validates :multimedia_evidence_response,
    length: { minimum: 1 }

  attribute :notice_to_provide_bad_character_evidence,
    Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :notice_to_provide_bad_character_evidence,
      boolean_presence: true,
      if: :not_guilty_anticipated_plea?
    validates :notice_to_provide_bad_character_evidence,
      boolean_absence: true,
      unless: :not_guilty_anticipated_plea?
  end
  validates :notice_to_provide_bad_character_evidence,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :bad_character_details, String
  with_options if: :first_hearing_case? do
    validates :bad_character_details,
      presence: true,
      if: :notice_to_provide_bad_character_evidence
    validates :bad_character_details,
      absence: true,
      unless: :notice_to_provide_bad_character_evidence
  end
  validates :bad_character_details,
    absence: true,
    if: :breach_of_bail_case?

  attribute :dealt_with_in_welsh, Virtus::Attribute::Boolean
  validates :dealt_with_in_welsh, boolean_presence: true

  attribute :person_remand_status, String
  validates :person_remand_status,
    inclusion: { in: Enumerations::PersonRemandStatus }

  attribute :given_charges, Virtus::Attribute::Boolean
  validates :given_charges,
    boolean_presence: true,
    if: :first_hearing_case?
  validates :given_charges,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :initiation_type, String
  validates :initiation_type,
    inclusion: { in: Enumerations::InitiationType },
    if: :first_hearing_case?
  validates :initiation_type,
    absence: true,
    if: :breach_of_bail_case?

  attribute :signed_charge_sheet, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :signed_charge_sheet,
      boolean_presence: true,
      if: :initiated_as_charge?
    validates :signed_charge_sheet,
      boolean_absence: true,
      unless: :initiated_as_charge?
  end
  validates :signed_charge_sheet,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :date_sent, Date
  with_options if: :first_hearing_case? do
    validates :date_sent,
      presence: true,
      if: :initiated_as_requisition?
    validates :date_sent,
      absence: true,
      unless: :initiated_as_requisition?
  end
  validates :date_sent,
    absence: true,
    if: :breach_of_bail_case?

  attribute :parent_guardian_copy, Virtus::Attribute::Boolean
  validates :parent_guardian_copy,
    absence: true,
    if: :breach_of_bail_case?

  attribute :parent_guardian_date_sent, Date
  with_options if: :first_hearing_case? do
    validates :parent_guardian_date_sent,
      presence: true,
      if: :parent_guardian_date_sent_needed?
  end
  validates :parent_guardian_date_sent,
    absence: true,
    if: :breach_of_bail_case?

  attribute :bail_conditions_provided, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :bail_conditions_provided,
      boolean_presence: true,
      if: :conditional_bail?
    validates :bail_conditions_provided,
      boolean_absence: true,
      unless: :conditional_bail?
  end
  validates :bail_conditions_provided,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :signed_for_bail, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :signed_for_bail,
      boolean_presence: true,
      if: :unconditional_bail?
    validates :signed_for_bail,
      boolean_absence: true,
      unless: :unconditional_bail?
  end
  validates :signed_for_bail,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :bail_conditions, Array[BailCondition]
  with_options if: :first_hearing_case? do
    validates :bail_conditions,
      length: { minimum: 1 },
      if: :conditional_bail?
  end
  validates :bail_conditions,
    length: { is: 0 },
    if: :breach_of_bail_case?

  attribute :interview, Interview
  validates :interview, presence: true

  attribute :domestic_violence, Array[DomesticViolence], relation: true
  with_options if: :first_hearing_case? do
    validates :domestic_violence,
      length: { minimum: 1 },
      if: :domestic_violence?
  end
  validates :domestic_violence?,
    length: { is: 0 },
    if: :breach_of_bail_case?

  attribute :first_hearing_datetime, DateTime
  validates :first_hearing_datetime, presence: true

  attribute :first_hearing_location, OrganisationLocation
  validates :first_hearing_location, presence: true

  def breach_order_title_needed?
    breach_order_title == 'other'
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

  def not_guilty_anticipated_plea?
    offences.any?(&:not_guilty_anticipated_plea?)
  end

  def validate_by_age
    age_at_case_date = age(case_file.date)
    return unless age_at_case_date
    is_adult = age_at_case_date >= ADULT_MIN_AGE
    if is_adult
      validate_as_adult
    else
      validate_as_youth
    end
  end
  validate :validate_by_age

  def validate_as_adult
    BooleanAbsenceValidator.new(attributes: [:parent_guardian_copy]).
      validate(self)
  end

  def validate_as_youth
    BooleanPresenceValidator.new(attributes: [:parent_guardian_copy]).
      validate(self)
    interview.validate_as_youth if interview.respond_to?(:validate_as_youth)
  end

  def parent_guardian_date_sent_needed?
    parent_guardian_copy && initiated_as_requisition?
  end

  delegate :domestic_violence?, to: :case_file
end
