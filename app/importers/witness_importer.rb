class WitnessImporter < TypeBasedImporter
  def self.importer_class
    {
      'NgapOtherWitness' => NgapOtherWitnessImporter,
      'StatementWitness' => StatementWitnessImporter,
      'ExpertWitness' => ExpertWitnessImporter,
      'OrganisationVictim' => OrganisationVictimImporter,
      'PersonVictim' => PersonVictimImporter
    }
  end
end
