class PersonVictimMapper < Yaks::Mapper
  attributes \
    :witness_id,
    :type,
    :nature_of_involvement,
    :evidence_they_can_give,
    :special_measures,
    :interpretor_required,
    :interpretor_language_or_dialect,
    :wish_to_use_video_link,
    :victim_code_requirements_met,
    :has_the_victim_made_a_vps_isb,
    :is_retraction_statement,
    :compensation_applications,
    :name,
    :date_of_birth,
    :reason_dob_not_provided,
    :visually_recorded_interview,
    :url,
    :injuries

  attribute :witness_type do
    object.witness_type.value
  end

  attribute :victim_wish_to_attend_court do
    object.victim_wish_to_attend_court.value
  end

  attribute :rep_wish do
    object.rep_wish.value
  end
end
