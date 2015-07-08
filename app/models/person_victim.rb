class PersonVictim < Victim
  attribute :type, String, writer: :private, default: 'PersonVictim'

  attribute :name, OrganisationName
  attribute :name, PersonName
  attribute :date_of_birth, Date
  attribute :reason_dob_not_provided, String
  attribute :visually_recorded_interview, Boolean
  attribute :url, String
  attribute :special_measures, Boolean
  attribute :injuries, Injuries
  attribute :wish_to_use_video_link, Boolean
end
