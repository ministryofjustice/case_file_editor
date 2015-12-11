class CaseImporter < TypeBasedImporter
  def self.importer_class
    {
      'FirstHearingDCF' => FirstHearingCaseFileImporter,
      'BobDCF' => BreachOfBailCaseFileImporter
    }
  end
end
