class OffenceCollectionImporter < TypeBasedImporter
  def self.importer_class
    {
      'AssaultOffences' => AssaultOffenceCollectionImporter,
      'GenericOffences' => GenericOffenceCollectionImporter,
      'RetailTheftOffences' => RetailTheftOffenceCollectionImporter
    }
  end
end
