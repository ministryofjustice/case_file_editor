class PersonVictim < Victim
  include Person

  attribute :type, String, writer: :private, default: 'PersonVictim'

  attribute :name, Name
  validates :name, presence: true

  attribute :date_of_birth, Date

  attribute :reason_dob_not_provided, String
  validates :reason_dob_not_provided,
    presence: true,
    unless: :date_of_birth

  attribute :visually_recorded_interview, Virtus::Attribute::Boolean
  validates :visually_recorded_interview, boolean_presence: true

  attribute :url, String

  attribute :special_measures, Virtus::Attribute::Boolean
  validates :special_measures,
    boolean_presence: true,
    if: :victim_to_read?

  attribute :injuries, Array[Injury]

  attribute :wish_to_use_video_link, Virtus::Attribute::Boolean
  validates :wish_to_use_video_link,
    boolean_presence: true,
    if: :victim_to_read?

  def victim_to_read?
    victim_wish_to_attend_court == 'yes_victim_to_read'
  end
end
