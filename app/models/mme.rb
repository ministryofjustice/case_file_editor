class Mme < Event
  attribute :id, String
  attribute :date, Date
  attribute :end_date, Date
  attribute :type, Mmetype
  attribute :evidential_value, Boolean
  attribute :relied_upon_trial, Boolean
  attribute :relied_upon_sentence, Boolean
  attribute :description_of_what_is_seen_in_multimedia_evidence, Array[String]
  attribute :total_duration, String
  attribute :url, String
end
