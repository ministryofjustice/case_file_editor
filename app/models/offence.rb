class Offence < Event
  extend AbstractClass

  attribute :type, String, writer: :private, default: 'Offence'

  attribute :from_date, Date
  validates :from_date, presence: true

  attribute :to_date, Date
  validates :to_date, presence: true

  attribute :charge_date, Date
  validates :charge_date, presence: true

  attribute :offence_title, String
  validates :offence_title, presence: true

  attribute :charge_wording,  String
  validates :charge_wording, presence: true

  attribute :reply_to_charge, String

  attribute :points_to_prove_met_by, String
  validates :points_to_prove_met_by, presence: true

  attribute :demeanour_at_incident, String

  attribute :anticipated_plea, String
  validates :anticipated_plea, inclusion: { in: Enumerations::PleaStatusCode }

  attribute :committed_on_bail, Virtus::Attribute::Boolean
  validates :committed_on_bail, boolean_presence: true

  attribute :children_present, Virtus::Attribute::Boolean

  attribute :ages_of_children, Array[String]
  validates :ages_of_children,
    length: { minimum: 1 },
    if: :children_present

  def not_guilty_anticipated_plea?
    anticipated_plea == 'not_guilty'
  end

  def validate_domestic_violence_specific(is_dv)
    if is_dv
      validate_domestic_violence
    else
      validate_not_domestic_violence
    end
  end

private

  def validate_domestic_violence
    PresenceValidator.new(attributes: [:demeanour_at_incident]).
      validate(self)
    BooleanPresenceValidator.new(attributes: [:children_present]).
      validate(self)
  end

  def validate_not_domestic_violence
    AbsenceValidator.new(attributes: [:demeanour_at_incident]).
      validate(self)
    BooleanAbsenceValidator.new(attributes: [:children_present]).
      validate(self)
  end
end
