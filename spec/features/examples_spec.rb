RSpec.describe 'Parsing example files' do
  let(:dcf) {
    CaseImporter.new(source).import
  }

  let(:source) {
    JSON.load(
      File.read(
        File.expand_path("../../fixtures/#{name}.json", __FILE__)))
  }

  let(:errors) {
    RecursiveValidator.new(dcf).errors
  }

  context 'example 01' do
    let(:name) { 'example_01' }

    it 'does not require Case#likely_case_progression for GAP' do
      expect(errors).not_to have_key(:likely_case_progression)
    end

    it 'does not require Case#is_hearsay for GAP' do
      expect(errors).not_to have_key(:is_hearsay)
    end

    it 'does not require Defendant#notice_to_provide_bad_character_evidence for GAP' do
      expect(errors).not_to have_key(:defendants)
    end

    it 'does not require CommonLawNotForDisclosure#details_of_relevant_unused_material' do
      expect(errors).not_to have_key(:common_law_disclosure)
    end
  end
end
