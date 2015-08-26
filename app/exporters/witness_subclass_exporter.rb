class WitnessSubclassExporter < GenericExporter
  def export
    super().merge('witness' => WitnessExporter.new(object).export)
  end
end
