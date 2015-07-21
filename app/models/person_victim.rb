class PersonVictim < Victim
  include Person

  attribute :type, String, writer: :private, default: 'PersonVictim'
  attribute :name, Name
  attribute :date_of_birth, Date
  attribute :reason_dob_not_provided, String
  attribute :visually_recorded_interview, Boolean
  attribute :url, String
  attribute :special_measures, Boolean
  attribute :injuries, Injury
  attribute :wish_to_use_video_link, Boolean
end
