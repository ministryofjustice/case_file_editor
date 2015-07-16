class MmeNotRecordedResponse < MmeResponse
  attribute :type, String, writer: :private, default: 'MmeNotRecordedResponse'
  attribute :defendant_admitted_to_location, Boolean
  attribute :how_is_identification_established, Boolean
end
