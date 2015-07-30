class PersonVictimExporter < GenericExporter
  attributes \
    :witness_id,
    :type,
    :witness_type,
    :nature_of_involvement,
    :evidence_they_can_give,
    :special_measures,
    :interpreter_required,
    :interpreter_language_or_dialect,
    :wish_to_use_video_link,
    :victim_code_requirements_met,
    :has_the_victim_made_a_vps_isb,
    :victim_wish_to_attend_court,
    :rep_wish,
    :is_retraction_statement,
    :compensation_applications,
    :name,
    :date_of_birth,
    :reason_dob_not_provided,
    :visually_recorded_interview,
    :url,
    :injuries
end
