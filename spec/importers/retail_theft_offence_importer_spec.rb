require 'rails_helper'

RSpec.describe RetailTheftOffenceImporter do
  let(:source) {
    {
      'type' => 'RetailTheftOffence',
      'cjs_offence_code' => 'h410',
      'offence' => {
        'type' => 'Offence',
        'from_date' => '2014-01-01',
        'to_date' => '2014-01-01',
        'offence_title' => 'Offence Title from PNLD',
        'charge_wording' => 'This is the charge wording',
        'points_to_prove_met_by' =>
          'Description of how the points to prove have been met.',
        'anticipated_plea' => 'guilty',
        'committed_on_bail' => false
      },
      'property_ids' => [1],
      'retail_theft_interview_extension' => {
        'admit_taking_property' => 'admits_all',
        'admit_being_dishonest' => true,
        'admit_intending_to_permanently_deprive' => true
      }
    }
  }

  subject {
    described_class.new(source).import
  }

  it 'creates a RetailTheftOffence' do
    expect(subject).to be_kind_of(RetailTheftOffence)
  end

  it 'imports top-level properties' do
    expect(subject.cjs_offence_code).to eq('h410')
  end

  it 'imports properties from the offence sub-object' do
    expect(subject.offence_title).to eq('Offence Title from PNLD')
  end
end
