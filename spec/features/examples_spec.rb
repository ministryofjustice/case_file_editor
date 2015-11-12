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

  context 'example 03' do
    let(:name) { 'example_03' }

    it 'identifies three errors on first defendant' do
      expect(errors).to eq(
        defendants: {
          0 => {
            class_a_drug_test_details: [
              "must be present when a Class A drug test is provided"
            ],
            accepts_drugs_result: [
              "must be present when a Class A drug test is provided"
            ],
            eec_convictions_record_received: [
              "must be present if defendant has EEC passports"
            ]
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

  context 'example 06' do
    let(:name) { 'example_06' }

    it 'identifies that the mme_id provided in the MMEResponse does not match mme on the case' do
           expect(errors).to match(
        defendants: {
          0 => {
            multimedia_evidence_response: {
		0 => {
		   id: [ "must refer to a piece of multimedia evidence in the case"]
	        }
            }
          }
        }
      )
    end
  end

  context 'example 07' do
    let(:name) { 'example_07' }

    it 'identifies that MmeNotRecordedResponse is invalid when there is MME' do
      expect(errors).to match(
        defendants: {
          0 => {
            multimedia_evidence_response: {
              0 => include(
                type: include("cannot be a not recorded response if there is multimedia evidence in the case")
              )
            }
          }
        }
      )
    end
  end

  context 'example 08' do
    let(:name) { 'example_09' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'example 09' do
    let(:name) { 'example_09' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'example 10' do
    let(:name) { 'example_10' }

    it 'identifies missing youth fields' do
      expect(errors).to eq(
        defendants: {
          0 => {
            parent_guardian_copy: [
              "must be present when defendant is under 18"
            ],
            interview: {
              appropriate_adults: [
                "must be present if defendant is a youth"
              ]
	    }
          }
        }
      )
    end
  end	

  context 'example 11' do
    let(:name) { 'example_11' }

    it 'identifies that madatory field brief description of the case is not present' do
      expect(errors).to match(
	brief_description_of_case: ["is invalid"]
      )
    end
  end

  context 'example 12' do
    let(:name) { 'example_12' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'example 13' do
    let(:name) { 'example_13' }

    it 'identifies the property ids referred to in the retail theft offences are not part of the case' do
      expect(errors).to eq(
        defendants: {
          0 => {
            offences: {
              0 => {
                retail_theft_offences: {
                  0 => {
                    property_ids: [
                      "must each refer to a piece of property in the case"
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
  
  context 'example 14' do
    let(:name) { 'example_14' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'example 15' do
    let(:name) { 'example_15' }

    it 'identifies no errors' do
      pending 'Scenario test files not updated t0 1.2.0'
      expect(errors).to eq({})
    end
  end

  context 'example 16' do
    let(:name) { 'example_16' }

    it 'identifies no errors' do
      pending 'Scenario test files not updated t0 1.2.0'
      expect(errors).to eq({})
    end
  end

  context 'example 17' do
    let(:name) { 'example_17' }

    it 'is NGAP' do
      pending 'Scenario test files not updated t0 1.2.0'
      expect(dcf).to be_not_guilty_anticipated_plea
    end
  end
end
