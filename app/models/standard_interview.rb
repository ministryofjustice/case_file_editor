class StandardInterview < Interview
  include Virtus.model
  include ActiveModel::Validations

  attribute :type, String, writer: :private, default: 'StandardInterview'

  attribute :date, Date
  validates :date, presence: true

  attribute :defendant_legally_represented, Boolean
  validates :defendant_legally_represented, inclusion: { in: [true, false] }

  attribute :legally_represented_by, PersonName
  validates :legally_represented_by,
    presence: true,
    if: :defendant_legally_represented

  attribute :legal_representative_firm, String
  validates :legal_representative_firm,
    presence: true,
    if: :defendant_legally_represented

  attribute :interpreters, Array[PersonName]
  validates :interpreters, array_uniqueness: true

  attribute :special_warnings_given, Boolean
  validates :special_warnings_given, inclusion: { in: [true, false] }

  attribute :no_comment_response, Boolean
  validates :no_comment_response, inclusion: { in: [true, false] }

  attribute :questions_asked, String
  validates :questions_asked,
    presence: true,
    if: :no_comment_response
  validates :questions_asked,
    absence: true,
    unless: :no_comment_response

  attribute :admissions_made, String
  attribute :denials, String
  attribute :defences, String
  attribute :explanations, String
  attribute :mitigations, String
  attribute :aggravating_features, String
  attribute :appropriate_adults, Name
end
