class StandardInterview < Interview
  include Virtus.model
  include ActiveModel::Validations

  attribute :type, String, writer: :private, default: 'StandardInterview'
  attribute :date, Date
  attribute :defendant_legally_represented, Boolean
  attribute :legally_represented_by, PersonName
  attribute :legal_representative_firm, String
  attribute :interpreters, Array[PersonName]
  attribute :special_warnings_given, String
  attribute :no_comment_response, Boolean
  attribute :questions_asked, String
  attribute :admissions_made, String
  attribute :denials, String
  attribute :defences, String
  attribute :explanations, String
  attribute :mitigations, String
  attribute :aggravating_features, String
  attribute :appropriate_adults, Name
end
