class CourtOrder
  include Virtus.model
  include ActiveModel::Validations

  attribute :court_order_title, String
  validates :court_order_title,
    inclusion: { in: Enumerations::CourtOrderTitle }

  attribute :court_order_title_other, String
  validates :court_order_title_other,
    presence: {
      message: 'must be present if court order title is ‘other’'
    },
    if: :court_order_title_needed?

  attribute :reason_for_request, String

  attribute :draft_conditions, Array[String]

  def court_order_title_needed?
    court_order_title == 'other'
  end
end
