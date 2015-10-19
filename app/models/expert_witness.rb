class ExpertWitness < Witness
  include AgeCalculation

  attribute :name, Name
  validates :name, presence: true

  attribute :date_of_birth, Date

  attribute :type, String, writer: :private, default: 'ExpertWitness'

  attribute :witness_type, Array[String], writer: :private, default: ['expert']

  attribute :evidence_they_can_give, String
  validates :evidence_they_can_give, presence: true
end
