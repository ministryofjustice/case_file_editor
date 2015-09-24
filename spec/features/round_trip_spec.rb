RSpec.describe 'Round-trip importing and exporting' do
  let(:dcf) {
    CaseImporter.new(source).import
  }

  let(:exported) {
    CaseExporter.new(dcf).export
  }

  context 'example_1.json' do
    let(:source) {
      JSON.load(
        File.read(
          File.expand_path('../../fixtures/example_1.json', __FILE__)))
    }

    it 'produces the same structure after being imported and exported' do
      expect(exported).to eq(source)
    end
  end
end
