class Arrest < Event
  attribute :type, String, default: 'arrest'
  attribute :date_time, DateTime
  attribute :comments_on_arrest_and_caution, String
end
