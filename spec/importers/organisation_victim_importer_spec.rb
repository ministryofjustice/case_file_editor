RSpec.describe OrganisationVictimImporter do
  let(:source) {
    {
      'type' => 'OrganisationVictim',
      'name' => {
        'type' => 'OrganisationName',
        'organisation_name' => 'ACME, Inc.'
      },
      'victim' => {
        'witness_type' => ['other'],
        'victim_code_requirements_met' => true,
        'has_the_victim_made_a_vps_isb' => false,
        'witness' => {
          'nature_of_involvement' => 'Nature of involvement',
          'evidence_they_can_give' => 'Evidence they can give'
        }
      }
    }
  }

  context 'imported object' do
    subject {
      described_class.new(source).import
    }

    it { is_expected.to be_kind_of(OrganisationVictim) }

    it 'has properties from the victim sub-object' do
      expect(subject.witness_type).to eq(['other'])
    end

    it 'has properties from the witness sub-sub-object' do
      expect(subject.nature_of_involvement).to eq('Nature of involvement')
    end

    context 'name' do
      subject { super().name }

      it { is_expected.to be_kind_of(OrganisationName) }

      it 'has organisation_name' do
        expect(subject.organisation_name).to eq('ACME, Inc.')
      end
    end
  end
end
