class Witness
  include BasicModel
  include DuplicateIdentifiers

  attribute :witness_id, String

  attribute :witness_type, Array[String]
  validates :witness_type,
    array_inclusion: { in: Enumerations::WitnessType },
    array_uniqueness: true,
    length: { minimum: 1 }

  attribute :nature_of_involvement, String
  validates :nature_of_involvement, presence: true

  attribute :evidence_they_can_give, String
  validates :evidence_they_can_give, presence: true

  attribute :special_measures, Virtus::Attribute::Boolean

  attribute :interpreter_required, Virtus::Attribute::Boolean

  attribute :interpreter_language_or_dialect, String
  validates :interpreter_language_or_dialect,
    presence: true,
    if: :interpreter_required

  attribute :wish_to_use_video_link, Virtus::Attribute::Boolean

  validates :special_measures, :interpreter_required, :wish_to_use_video_link,
    boolean_absence: true,
    unless: :not_guilty_anticipated_plea?
  validates :special_measures, :interpreter_required, :wish_to_use_video_link,
    boolean_presence: true,
    if: :not_guilty_anticipated_plea?

  def officer_witness?
    (Enumerations::OfficerWitnessType & witness_type).any?
  end

private

  def not_guilty_anticipated_plea?
    case_file.not_guilty_anticipated_plea?
  end

  def validate_id_uniqueness
    if duplicate_identifiers(case_file.witness_ids).include?(witness_id)
      errors.add :witness_id, :unique_within_case_file
    end
  end
  validate :validate_id_uniqueness
end
