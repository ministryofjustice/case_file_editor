class Mme < Event
  include DuplicateIdentifiers
  include CaseTypeSpecific

  HOURS_AND_MINUTES = /\A([01][0-9]|2[0-3]):[0-5][0-9]\z/
  attribute :id, String
  validates :id, presence: true

  attribute :date, Date
  validates :date, presence: true

  attribute :end_date, Date

  attribute :type, String
  validates :type, presence: true

  attribute :evidential_value, Virtus::Attribute::Boolean
  validates :evidential_value, truth: true

  attribute :relied_upon_trial, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :relied_upon_trial,
      truth: true,
      unless: :relied_upon_sentence
  end
  validates :relied_upon_trial,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :relied_upon_sentence, Virtus::Attribute::Boolean
  with_options if: :first_hearing_case? do
    validates :relied_upon_sentence,
      truth: true,
      unless: :relied_upon_trial
  end
  validates :relied_upon_sentence,
    boolean_absence: true,
    if: :breach_of_bail_case?

  attribute :description_of_what_is_contained_in_multimedia_evidence, String
  validates :description_of_what_is_contained_in_multimedia_evidence,
    presence: true

  attribute :total_duration, String
  validates :total_duration,
    format: { with: HOURS_AND_MINUTES }

  attribute :url, String

  def validate_id_uniqueness
    if duplicate_identifiers(case_file.mme_ids).include?(id)
      errors.add :id, :unique_within_case_file
    end
  end
  validate :validate_id_uniqueness
end
