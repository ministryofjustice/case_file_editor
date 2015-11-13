class NameImporter < TypeBasedImporter
  def self.importer_class
    {
      'PersonName' => PersonNameImporter,
      'OfficerName' => OfficerNameImporter,
      'OrganisationName' => OrganisationNameImporter
    }
  end
end
