class OffenceImporter < TypeBasedImporter
  def self.importer_class
    {
      'AssaultOffence' => AssaultOffenceImporter,
      'GenericOffence' => GenericOffenceImporter,
      'RetailTheftOffence' => RetailTheftOffenceImporter
    }
  end
end
