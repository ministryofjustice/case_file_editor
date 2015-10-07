class MmeRecordedResponse < MmeResponse
  attribute :type, String, writer: :private, default: 'MmeRecordedResponse'

  attribute :id, String
  validates :id, presence: true

  attribute :defendant_shown, Virtus::Attribute::Boolean
  validates :defendant_shown, boolean_presence: true

  attribute :reasons_if_not_shown, String
  validates :reasons_if_not_shown,
    presence: true,
    unless: :defendant_shown

  attribute :defendant_comments_if_shown, String
  validates :defendant_comments_if_shown,
    presence: true,
    if: :defendant_shown

  attribute :is_defendant_believed_to_be_in_the_mme, Virtus::Attribute::Boolean
  validates :is_defendant_believed_to_be_in_the_mme,
    boolean_presence: true

  attribute :defendant_admits_being_in_mme, Virtus::Attribute::Boolean
  validates :is_defendant_believed_to_be_in_the_mme,
    boolean_presence: true,
    if: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]
  validates :is_defendant_believed_to_be_in_the_mme,
    boolean_absence: true,
    unless: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]

  attribute :how_is_identification_established, String
  validates :how_is_identification_established,
    presence: true,
    unless: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]

  def validate_id(available_ids)
    return if id && available_ids.include?(id)
    errors.add :id, :refer_to_mme
  end
end
