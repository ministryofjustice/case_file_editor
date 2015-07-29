class WitnessImporter < TypeBasedImporter
  def self.importer_class
    {
      'NgapOtherWitness' => NgapOtherWitnessImporter,
      'StatementWitness' => StatementWitnessImporter,
      'OrganisationVictim' => OrganisationVictimImporter,
      'PersonVictim' => PersonVictimImporter
    }
  end
end
