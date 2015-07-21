class MmeRecordedResponse < MmeResponse
  attribute :type, String, writer: :private, default: 'MmeRecordedResponse'
  attribute :id, String
  attribute :defendant_shown, Boolean
  attribute :reasons_if_not_shown, String
  attribute :defendant_comments_if_shown, String
  attribute :is_defendant_believed_to_be_in_the_mme, Boolean
  attribute :defendant_admits_being_in_mme, Boolean
  attribute :how_is_identification_established, String
end
