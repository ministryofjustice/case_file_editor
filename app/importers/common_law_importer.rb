class CommonLawImporter < TypeBasedImporter
  def self.importer_class
    {
      'CommonLawNotForDisclosure' => CommonLawNotForDisclosureImporter,
      'CommonLawForDisclosure' => CommonLawForDisclosureImporter
    }
  end
end
