class StatementWitness < Witness
  include Person

  attribute :type, String, writer: :private, default: 'StatementWitness'

  attribute :name, PersonName
  validates :name, presence: true

  attribute :witness_type, Array[String]
  validates :witness_type,
    array_inclusion: { in: Enumerations::StatementWitnessType }

  attribute :date_of_birth, Date

  attribute :reason_dob_not_provided, String
  validates :reason_dob_not_provided,
    presence: {
      message: 'must be present unless date of birth is present'
    },
    unless: :date_of_birth

  attribute :visually_recorded_interview, Boolean
  validates :visually_recorded_interview, inclusion: { in: [true, false] }

  attribute :url, String
  validates :url,
    presence: {
      message: 'must be present if visually recorded'
    },
    if: :visually_recorded_interview
  validates :url,
    absence: {
      message: 'must be absent unless visually recorded'
    },
    unless: :visually_recorded_interview

  attribute :rank, String
  # TODO: validate present iff witness_type is an officer
end
