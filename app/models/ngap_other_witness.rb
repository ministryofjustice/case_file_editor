class NgapOtherWitness < Witness
  attribute :type, String, writer: :private, default: 'NgapOtherWitness'
  attribute :name, PersonName
  attribute :witness_type, Array[WitnessType]
  attribute :number, String
  attribute :rank, String
end
