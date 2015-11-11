class Witness
  include BasicModel

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

  def officer_witness?
    (Enumerations::OfficerWitnessType & witness_type).any?
  end

  def validate_as_gap
    BooleanAbsenceValidator.new(
      attributes: [
        :special_measures, :interpreter_required, :wish_to_use_video_link
      ]
    ).validate(self)
  end

  def validate_as_ngap
    BooleanPresenceValidator.new(
      attributes: [
        :special_measures, :interpreter_required, :wish_to_use_video_link
      ]
    ).validate(self)
  end
end
