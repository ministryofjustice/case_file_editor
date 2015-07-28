class StatementWitnessMapper < Yaks::Mapper
  attributes \
    :witness_id,
    :type,
    :nature_of_involvement,
    :evidence_they_can_give,
    :special_measures,
    :interpretor_required,
    :interpretor_language_or_dialect,
    :wish_to_use_video_link,
    :name,
    :date_of_birth,
    :reason_dob_not_provided,
    :visually_recorded_interview,
    :url,
    :rank

  attribute :witness_type do
    object.witness_type.value
  end
end
