class CourtOrder
  include Virtus.model
  include ActiveModel::Validations

  attribute :court_order_title, String
  validates :court_order_title,
    inclusion: { in: Enumerations::CourtOrderTitle }
  attribute :court_order_title_other, String
  attribute :reason_for_request, String
  attribute :draft_conditions, Array[String]
end
