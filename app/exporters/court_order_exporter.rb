class CourtOrderExporter < GenericExporter
  attributes \
    :court_order_title,
    :court_order_title_other,
    :reason_for_request,
    :draft_conditions

  def export
    exported = super
    exported.merge(
      court_order_title: { court_order_title: exported[:court_order_title] }
    )
  end
end
