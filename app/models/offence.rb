class Offence < Event
  extend AbstractClass

  attribute :type, String, writer: :private, default: 'Offence'

  attribute :from_date, Date
  validates :from_date, presence: true

  attribute :to_date, Date
  validates :to_date, presence: true

  attribute :offence_title, String
  validates :offence_title, presence: true

  attribute :charge_wording,  String
  validates :charge_wording, presence: true

  attribute :reply_to_charge, String

  attribute :points_to_prove_met_by, String
  validates :points_to_prove_met_by, presence: true

  attribute :demeanour_at_incident, String
  # TODO: validate present iff case is DV

  attribute :anticipated_plea, String
  validates :anticipated_plea, inclusion: { in: Enumerations::PleaStatusCode }

  attribute :committed_on_bail, Boolean
  validates :committed_on_bail, inclusion: { in: [true, false] }

  attribute :children_present, Boolean
  # TODO: validate present if case is DV

  attribute :ages_of_children, Array[String]
  validates :ages_of_children,
    length: { minimum: 1 },
    if: :children_present
end
