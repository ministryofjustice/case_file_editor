class CommonLawImporter < TypeBasedImporter
  def self.importer_class
    {
      'CommonLawNotForDisclosure' => CommonLawNotForDisclosureImporter,
    }
  end
end
