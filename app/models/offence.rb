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
  validates :demeanour_at_incident,
    presence: true,
    if: :domestic_violence?
  validates :demeanour_at_incident,
    absence: true,
    unless: :domestic_violence?

  attribute :anticipated_plea, String
  validates :anticipated_plea, inclusion: { in: Enumerations::PleaStatusCode }

  attribute :committed_on_bail, Virtus::Attribute::Boolean
  validates :committed_on_bail, boolean_presence: true

  attribute :children_present, Virtus::Attribute::Boolean
  validates :children_present,
    boolean_presence: true,
    if: :domestic_violence?
  validates :children_present,
    boolean_absence: true,
    unless: :domestic_violence?

  attribute :ages_of_children, Array[String]
  validates :ages_of_children,
    length: { minimum: 1 },
    if: :children_present

  delegate :domestic_violence?, to: :offence_collection

  def not_guilty_anticipated_plea?
    anticipated_plea == 'not_guilty'
  end
end
