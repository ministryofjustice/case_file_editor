require 'rails_helper'

RSpec.describe 'Parsing first hearing files' do
  let(:dcf) {
    CaseFileImporter.new(source).import
  }

  let(:source) {
    JSON.load(
      File.read(
        File.expand_path("../../fixtures/#{name}.json", __FILE__)))
  }

  let(:errors) {
    RecursiveValidator.new(dcf).errors
  }

  context 'first hearing 01' do
    let(:name) { 'first_hearing_01' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'first hearing 02' do
    let(:name) { 'first_hearing_02' }

    it 'identifies one error on case' do
      expect(errors).to eq(
        case: {
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
        }
      )
    end
  end

  context 'first hearing 03' do
    let(:name) { 'first_hearing_03' }

    it 'identifies three errors on first defendant' do
      expect(errors).to eq(
        case: {
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
        }
      )
    end
  end

  context 'first hearing 04' do
    let(:name) { 'first_hearing_04' }

    it 'identifies two errors on first defendant' do
      expect(errors).to eq(
        case: {
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
        }
      )
    end
  end

  context 'first hearing 05' do
    let(:name) { 'first_hearing_05' }

    it 'complains that special_measures is present for GAP' do
      expect(errors).to match(
        case: {
          witnesses: { 0 => { special_measures: anything } }
        }
      )
    end
  end

  context 'first hearing 06' do
    let(:name) { 'first_hearing_06' }

    it 'identifies that the mme_id provided in the MMEResponse does not match mme on the case' do
      expect(errors).to match(
        case: {
          defendants: {
            0 => {
              multimedia_evidence_response: {
                0 => {
                  id: ["must refer to a piece of multimedia evidence in the case"]
                }
              }
            }
          }
        }
      )
    end
  end

  context 'first hearing 07' do
    let(:name) { 'first_hearing_07' }

    it 'identifies that MmeNotRecordedResponse is invalid when there is MME' do
      expect(errors).to match(
        case: {
          defendants: {
            0 => {
              multimedia_evidence_response: {
                0 => include(
                  type: include("cannot be a not recorded response if there is multimedia evidence in the case")
                )
              }
            }
          }
        }
      )
    end
  end

  context 'first hearing 08' do
    let(:name) { 'first_hearing_09' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'first hearing 09' do
    let(:name) { 'first_hearing_09' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'first hearing 10' do
    let(:name) { 'first_hearing_10' }

    it 'identifies missing youth fields' do
      expect(errors).to eq(
        case: {
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
        }
      )
    end
  end

  context 'first hearing 11' do
    let(:name) { 'first_hearing_11' }

    it 'identifies that madatory field brief description of the case is not present' do
      expect(errors).to match(
        case: {
          brief_description_of_case: ["is invalid"]
        }
      )
    end
  end

  context 'first hearing 12' do
    let(:name) { 'first_hearing_12' }

    it 'identifies no errors' do
      expect(errors).to eq({})
    end
  end

  context 'first hearing 13' do
    let(:name) { 'first_hearing_13' }

    it 'identifies the property ids referred to in the retail theft offences are not part of the case' do
      expect(errors).to eq(
        case: {
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
        }
      )
    end
  end
end
