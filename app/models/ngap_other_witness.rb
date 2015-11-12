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

  attribute :collar_number, String
  validates :collar_number,
    presence: true,
    if: :officer_witness?
  validates :collar_number,
    absence: true,
    unless: :officer_witness?
end
