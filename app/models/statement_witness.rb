class StatementWitness < Witness
  include Person

  attribute :type, String, writer: :private, default: 'StatementWitness'

  attribute :name, Name
  validates :name, presence: true

  attribute :witness_type, Array[String]
  validates :witness_type,
    array_inclusion: { in: Enumerations::StatementWitnessType }

  attribute :reason_dob_not_provided, String
  validates :reason_dob_not_provided,
    presence: true,
    unless: :date_of_birth

  attribute :visually_recorded_interview, Virtus::Attribute::Boolean
  validates :visually_recorded_interview, boolean_presence: true

  attribute :url, String
  validates :url,
    presence: true,
    if: :visually_recorded_interview
  validates :url,
    absence: true,
    unless: :visually_recorded_interview
end
