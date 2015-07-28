class CourtOrderMapper < Yaks::Mapper
  attributes \
    :court_order_title,
    :court_order_title_other,
    :reason_for_request,
    :draft_conditions
end
