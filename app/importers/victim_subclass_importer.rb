class VictimSubclassImporter < WitnessSubclassImporter
private

  def source
    victim = @source.fetch('victim', {})
    witness = victim.fetch('witness', {})
    witness.merge(victim).merge(@source)
  end
end
