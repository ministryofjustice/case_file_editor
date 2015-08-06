class MmeRecordedResponse < MmeResponse
  attribute :type, String, writer: :private, default: 'MmeRecordedResponse'

  attribute :id, String
  validates :id, presence: true

  attribute :defendant_shown, Boolean
  validates :defendant_shown, inclusion: { in: [true, false] }

  attribute :reasons_if_not_shown, String
  validates :reasons_if_not_shown,
    presence: true,
    unless: :defendant_shown

  attribute :defendant_comments_if_shown, String
  validates :defendant_comments_if_shown,
    presence: true,
    if: :defendant_shown

  attribute :is_defendant_believed_to_be_in_the_mme, Boolean
  validates :is_defendant_believed_to_be_in_the_mme,
    inclusion: { in: [true, false] }

  attribute :defendant_admits_being_in_mme, Boolean
  validates :is_defendant_believed_to_be_in_the_mme,
    inclusion: { in: [true, false] },
    if: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]
  validates :is_defendant_believed_to_be_in_the_mme,
    inclusion: { in: [nil] },
    unless: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]

  attribute :how_is_identification_established, String
  validates :how_is_identification_established,
    presence: true,
    unless: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]
end
