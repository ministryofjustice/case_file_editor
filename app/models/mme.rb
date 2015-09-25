class Mme < Event
  HOURS_AND_MINUTES = /\A([01][0-9]|2[0-3]):[0-5][0-9]\z/
  attribute :id, String
  validates :id, presence: true
  # TODO: validate uniqueness within case

  attribute :date, Date
  validates :date, presence: true

  attribute :end_date, Date

  attribute :type, String
  validates :type,
    inclusion: { in: Enumerations::MmeType }

  attribute :evidential_value, Virtus::Attribute::Boolean
  validates :evidential_value, truth: true

  attribute :relied_upon_trial, Virtus::Attribute::Boolean
  validates :relied_upon_trial,
    truth: {
      message: 'must be true unless relied upon at sentence'
    },
    unless: :relied_upon_sentence
  validates :relied_upon_trial,
    falsehood: {
      message: 'must be false if relied upon at sentence'
    },
    if: :relied_upon_sentence

  attribute :relied_upon_sentence, Virtus::Attribute::Boolean
  validates :relied_upon_sentence,
    truth: {
      message: 'must be true unless relied upon at trial'
    },
    unless: :relied_upon_trial
  validates :relied_upon_sentence,
    falsehood: {
      message: 'must be false if relied upon at trial'
    },
    if: :relied_upon_trial

  attribute :description_of_what_is_contained_in_multimedia_evidence, String
  validates :description_of_what_is_contained_in_multimedia_evidence,
    presence: true

  attribute :total_duration, String
  validates :total_duration,
    format: { with: HOURS_AND_MINUTES }

  attribute :url, String
end
