class Mme < Event
  attribute :id, String
  attribute :date, Date
  attribute :end_date, Date
  attribute :type, String
  validates :type, inclusion: { in: Enumerations::MmeType }
  attribute :evidential_value, Boolean
  attribute :relied_upon_trial, Boolean
  attribute :relied_upon_sentence, Boolean
  attribute :description_of_what_is_contained_in_multimedia_evidence, String
  attribute :total_duration, String
  attribute :url, String
end
