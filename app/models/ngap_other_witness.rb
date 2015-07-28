class NgapOtherWitness < Witness
  attribute :type, String, writer: :private, default: 'NgapOtherWitness'
  attribute :name, PersonName
  attribute :witness_type, Array[String]
  validates :witness_type, array_inclusion: { in: Enumerations::WitnessType }
  attribute :number, String
  attribute :rank, String
end
