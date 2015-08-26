class NameImporter < GenericImporter
  def self.importer(source)
    if source.key?('organisation_name')
      OrganisationNameImporter.new(source)
    elsif source.key?('surname')
      PersonNameImporter.new(source)
    end
  end
end
