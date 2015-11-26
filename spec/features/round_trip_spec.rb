RSpec.describe 'Round-trip importing and exporting' do
  let(:dcf) {
    CaseFileImporter.importer(source).import
  }

  let(:exported) {
    CaseFileExporter.exporter(dcf).export
  }

  context 'first_hearing_01.json' do
    let(:source) {
      JSON.load(
        File.read(
          File.expand_path('../../fixtures/first_hearing_01.json', __FILE__)))
    }

    it 'imports a First Hearing case file' do
      expect(dcf).to be_a(FirstHearingCaseFile)
    end

    it 'produces the same structure after being imported and exported' do
      expect(exported).to eq(source)
    end
  end

  context 'breach_of_bail_01.json' do
    let(:source) {
      JSON.load(
        File.read(
          File.expand_path('../../fixtures/breach_of_bail_01.json', __FILE__)))
    }

    it 'imports a Breach of Bail case file' do
      expect(dcf).to be_a(BreachOfBailCaseFile)
    end

    it 'produces the same structure after being imported and exported' do
      expect(exported).to eq(source)
    end
  end
end
