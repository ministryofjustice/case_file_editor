class NgapOtherWitness < Witness
  attribute :type, String, writer: :private, default: 'NgapOtherWitness'

  attribute :name, PersonName
  validates :name, presence: true

  attribute :witness_type, Array[String]
  validates :witness_type,
    array_inclusion: { in: Enumerations::NgapWitnessType }

  attribute :number, String

  attribute :rank, String
  # TODO: validate present iff witness_type is an officer
end
