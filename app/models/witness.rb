class Witness
  include Virtus.model

  attribute :witness_id, String
  attribute :type, String
  attribute :witness_type, Array[WitnessType]
  attribute :nature_of_involvement, String
  attribute :evidence_they_can_give, String
  attribute :special_measures, Boolean
  attribute :interpretor_required, Boolean
  attribute :interpretor_language_or_dialect, String
  attribute :wish_to_use_video_link, Boolean
end
