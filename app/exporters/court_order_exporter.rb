class CourtOrderExporter < GenericExporter
  attributes \
    :court_order_title,
    :court_order_title_other,
    :reason_for_request,
    :draft_conditions

  def export
    super.merge(
      'court_order_title' => {
        'court_order_title' => object.court_order_title
      }
    )
  end
end
