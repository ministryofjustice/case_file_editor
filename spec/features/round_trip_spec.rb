RSpec.describe 'Round-trip importing and exporting' do
  let(:dcf) {
    CaseFileImporter.new(source).import
  }

  let(:exported) {
    CaseFileExporter.new(dcf).export
  }

  context 'first_hearing_01.json' do
    let(:source) {
      JSON.load(
        File.read(
          File.expand_path('../../fixtures/first_hearing_01.json', __FILE__)))
    }

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

    it 'produces the same structure after being imported and exported' do
      pending
      expect(exported).to eq(source)
    end
  end
end
