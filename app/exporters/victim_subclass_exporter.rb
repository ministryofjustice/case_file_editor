class VictimSubclassExporter < GenericExporter
  def export
    super().merge('victim' => VictimExporter.new(object).export)
  end
end
