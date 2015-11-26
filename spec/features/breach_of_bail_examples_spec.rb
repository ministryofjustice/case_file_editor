require 'rails_helper'

RSpec.describe 'Parsing breach of bail files' do
  let(:dcf) {
    BreachOfBailCaseFileImporter.new(source).import
  }

  let(:source) {
    JSON.load(
      File.read(
        File.expand_path("../../fixtures/#{name}.json", __FILE__)))
  }

  let(:errors) {
    RecursiveValidator.new(dcf).errors
  }

  context 'breach of bail 01' do
    let(:name) { 'breach_of_bail_01' }

    it 'identifies errors' do
      expect(errors).to eq(
        defendants: {
          0 => {
            domestic_violence?: [
              "is the wrong length (should be 0)"
            ]
          }
        },
        multimedia_evidence: {
          0 => {
            relied_upon_trial: [
              "must be true unless relied upon at sentence"
            ],
            relied_upon_sentence: [
              "must be true unless relied upon at trial"
            ]
          }
        }
      )
    end
  end
end
