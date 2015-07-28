class CourtOrderMapper < Yaks::Mapper
  attributes \
    :court_order_title_other,
    :reason_for_request,
    :draft_conditions

  attribute :court_order_title do
    object.court_order_title.value
  end
end
