class Arrest < Event
  attribute :type, String, writer: :private, default: 'Arrest'

  attribute :date_time, DateTime
  validates :date_time, presence: true

  attribute :comments_on_arrest_and_caution, String
end
