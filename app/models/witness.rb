class Witness
  include Virtus.model
  include ActiveModel::Validations

  attribute :witness_id, String
  # TODO: validate unique within case file

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
  # TODO: validate present iff case is NGAP

  attribute :interpreter_required, Virtus::Attribute::Boolean
  # TODO: validate present only for 'other witnesses' iff case is NGAP

  attribute :interpreter_language_or_dialect, String
  validates :interpreter_language_or_dialect,
    presence: {
      message: 'must be present if interpreter required'
    },
    if: :interpreter_required

  attribute :wish_to_use_video_link, Virtus::Attribute::Boolean
  # TODO: validate present iff case is NGAP
end
