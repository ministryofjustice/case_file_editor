class CourtOrder
  include Virtus.model

  attribute :court_order_title, CourtOrderTitle
  attribute :court_order_title_other, String
  attribute :reason_for_request, String
  attribute :draft_conditions, Array[String]
end
