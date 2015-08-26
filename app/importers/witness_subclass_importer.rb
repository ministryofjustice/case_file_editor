class WitnessSubclassImporter < GenericImporter
private

  def source
    @source.fetch('witness', {}).merge(@source)
  end
end
