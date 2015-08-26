class OffenceSubclassExporter < GenericExporter
  def export
    super().merge('offence' => OffenceExporter.new(object).export)
  end
end
