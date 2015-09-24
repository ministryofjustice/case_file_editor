RSpec.describe PersonVictimImporter do
  let(:source) {
    {
      'type' => 'PersonVictim',
      'name' => {
        'given_name' => ['Jennie', 'Claire'],
        'surname' => 'Jones'
      },
      'date_of_birth' => '1980-08-01',
      'visually_recorded_interview' => false,
      'special_measures' => false,
      'wish_to_use_video_link' => false,
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

    it { is_expected.to be_kind_of(PersonVictim) }

    it 'has top-level properties' do
      expect(subject.date_of_birth).to eq(Date.new(1980, 8, 1))
    end

    it 'has properties from the victim sub-object' do
      expect(subject.witness_type).to eq(['other'])
    end

    it 'has properties from the witness sub-sub-object' do
      expect(subject.nature_of_involvement).to eq('Nature of involvement')
    end

    context 'name' do
      subject { super().name }

      it { is_expected.to be_kind_of(PersonName) }

      it 'has given_name' do
        expect(subject.given_name).to eq(%w[ Jennie Claire ])
      end

      it 'has surname' do
        expect(subject.surname).to eq('Jones')
      end
    end
  end
end
