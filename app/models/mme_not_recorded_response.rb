class MmeNotRecordedResponse < MmeResponse
  attribute :type, String, writer: :private, default: 'MmeNotRecordedResponse'

  attribute :defendant_admitted_to_location, Virtus::Attribute::Boolean
  validates :defendant_admitted_to_location, boolean_presence: true

  attribute :how_is_identification_established, String
  validates :how_is_identification_established, presence: true
end
