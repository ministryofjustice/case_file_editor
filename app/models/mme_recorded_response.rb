class MmeRecordedResponse < MmeResponse
  attribute :type, String, writer: :private, default: 'MmeRecordedResponse'

  attribute :id, String
  validates :id, presence: true

  attribute :defendant_shown, Virtus::Attribute::Boolean
  validates :defendant_shown, boolean_presence: true

  attribute :reasons_if_not_shown, String
  validates :reasons_if_not_shown,
    presence: {
      message: 'must be present unless shown to defendant'
    },
    unless: :defendant_shown

  attribute :defendant_comments_if_shown, String
  validates :defendant_comments_if_shown,
    presence: {
      message: 'must be present if shown to defendant'
    },
    if: :defendant_shown

  attribute :is_defendant_believed_to_be_in_the_mme, Virtus::Attribute::Boolean
  validates :is_defendant_believed_to_be_in_the_mme,
    boolean_presence: true

  attribute :defendant_admits_being_in_mme, Virtus::Attribute::Boolean
  validates :is_defendant_believed_to_be_in_the_mme,
    boolean_presence: {
      message: 'must be present if shown to defendant and defendant believed to be in the MME'
    },
    if: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]
  validates :is_defendant_believed_to_be_in_the_mme,
    boolean_absence: {
      message: 'must be absent unless shown to defendant and defendant believed to be in the MME'
    },
    unless: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]

  attribute :how_is_identification_established, String
  validates :how_is_identification_established,
    presence: {
      message: 'must be present if shown to defendant and defendant believed to be in the MME'
    },
    unless: [:defendant_shown, :is_defendant_believed_to_be_in_the_mme]
end
