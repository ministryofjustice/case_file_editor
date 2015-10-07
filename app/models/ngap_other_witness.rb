class NgapOtherWitness < Witness
  attribute :type, String, writer: :private, default: 'NgapOtherWitness'

  attribute :name, PersonName
  validates :name, presence: true

  attribute :witness_type, Array[String]
  validates :witness_type,
    array_inclusion: { in: Enumerations::NgapWitnessType }

  attribute :number, String

  attribute :rank, String
  validates :rank,
    presence: true,
    if: :officer_witness?
  validates :rank,
    absence: true,
    unless: :officer_witness?

private

  def validate_ngap
    super
    BooleanPresenceValidator.new(attributes: [:interpreter_required]).
      validate(self)
  end
end
