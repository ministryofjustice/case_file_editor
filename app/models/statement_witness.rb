class StatementWitness < Witness
  include Person

  attribute :type, String, writer: :private, default: 'StatementWitness'
  attribute :name, PersonName
  attribute :witness_type, Array[WitnessType]
  attribute :date_of_birth, Date
  attribute :reason_dob_not_provided, String
  attribute :visually_recorded_interview, Boolean
  attribute :url, String
  attribute :rank, String
end
