class NgapOtherWitness < Witness
  attribute :type, String, writer: :private, default: 'NgapOtherWitness'

  attribute :name, PersonName
  validates :name, presence: true

  attribute :witness_type, Array[String]
  validates :witness_type,
    array_inclusion: { in: Enumerations::NgapWitnessType }

  attribute :number, String

  # TODO: validate present iff witness_type is an officer
  attribute :rank, String

private

  def validate_ngap
    super
    if interpreter_required.nil?
      errors.add :interpreter_required, :blank
    end
  end
end
