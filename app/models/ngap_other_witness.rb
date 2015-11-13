class NgapOtherWitness < Witness
  attribute :type, String, writer: :private, default: 'NgapOtherWitness'

  attribute :name, Name
  validates :name, presence: true

  attribute :witness_type, Array[String]
  validates :witness_type,
    array_inclusion: { in: Enumerations::NgapWitnessType }

  attribute :number, String

end
