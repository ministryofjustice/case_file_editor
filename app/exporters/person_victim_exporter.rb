class PersonVictimExporter < VictimSubclassExporter
  attributes \
    :type,
    :name,
    :date_of_birth,
    :reason_dob_not_provided,
    :visually_recorded_interview,
    :url,
    :special_measures,
    :injuries,
    :wish_to_use_video_link
end
