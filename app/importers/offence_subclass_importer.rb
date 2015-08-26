class OffenceSubclassImporter < GenericImporter
private

  def source
    @source.fetch('offence', {}).merge(@source)
  end
end
