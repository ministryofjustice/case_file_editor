class CourtOrder
  include BasicModel

  attribute :court_order_title, String
  validates :court_order_title,
    inclusion: { in: Enumerations::CourtOrderTitle }

  attribute :court_order_title_other, String
  validates :court_order_title_other,
    presence: true,
    if: :court_order_title_needed?

  attribute :reason_for_request, String

  attribute :draft_conditions, Array[String]

  def court_order_title_needed?
    court_order_title == 'other'
  end
end
