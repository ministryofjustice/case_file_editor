class MmeNotRecordedResponse < MmeResponse
  attribute :type, String, writer: :private, default: 'MmeNotRecordedResponse'

  attribute :defendant_admitted_to_location, Virtus::Attribute::Boolean
  validates :defendant_admitted_to_location, boolean_presence: true

  attribute :how_is_identification_established, String
  validates :how_is_identification_established, presence: true

  def validate_no_mme_not_recorded_if_mme_present
    if defendant.case_file.multimedia_evidence.any?
      errors.add :type, :response_required
    end
  end
  validate :validate_no_mme_not_recorded_if_mme_present
end
