require 'rails_helper'

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

    it 'allows Mme#relied_upon_sentence and #relied_upon_trial both to be true' do
      expect(errors).not_to have_key(:multimedia_evidence)
    end

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'example 02' do
    let(:name) { 'example_02' }

    it 'identifies one error on case' do
      expect(errors).to eq(
        case_markers: ["must all be one of the allowed values"],
        defendants: {
          0 => {
            offences: {
              0 => {
                retail_theft_offences: {
                  0 => {
                    demeanour_at_incident: [
                      "must be absent if case is not domestic violence"
                    ]
                  }
                }
              }
            }
          }
        }
      )
    end
  end

  context 'example 04' do
    let(:name) { 'example_04' }

    it 'identifies two errors on first defendant' do
      expect(errors).to eq(
        defendants: {
          0 => {
            eec_check_submitted: [
              "must be absent unless defendant has EEC passports"
            ],
            eec_convictions_record_received: [
              "must be absent unless defendant has EEC passports"
            ]
          }
        }
      )
    end
  end

  context 'example 05' do
    let(:name) { 'example_05' }

    it 'complains that special_measures is present for GAP' do
      expect(errors).to match(
        witnesses: { 0 => { special_measures: anything } }
      )
    end
  end

  context 'example 08' do
    let(:name) { 'example_08' }

    it 'identifies one error on first defendant’s first MME response' do
      expect(errors).to eq(
        defendants: {
          0 => {
            multimedia_evidence_response: {
              0 => {
                defendant_admitted_to_location: ["is required"]
              }
            }
          }
        }
      )
    end
  end

  context 'example 09' do
    let(:name) { 'example_09' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'example 12' do
    let(:name) { 'example_12' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end
end
