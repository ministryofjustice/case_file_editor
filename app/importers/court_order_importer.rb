class CourtOrderImporter < GenericImporter
  def params
    super.merge(court_order_title: court_order_title)
  end

  def court_order_title
    @object.fetch('court_order_title', {}).fetch('court_order_title', nil)
  end
end
