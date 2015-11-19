RSpec.describe PersonVictimExporter do
  let(:victim) {
    PersonVictim.new(
      witness_type: ['other'],
      name: PersonName.new(
        type: 'PersonName',
        given_name: ['Jennie', 'Claire'],
        surname: 'Jones'
      ),
      date_of_birth: Date.new(1980, 8, 1),
      visually_recorded_interview: false,
      nature_of_involvement: 'Nature of involvement',
      evidence_they_can_give: 'Evidence they can give',
      victim_code_requirements_met: true,
      has_the_victim_made_a_vps_isb: false
    )
  }

  context 'exported hash' do
    subject { described_class.new(victim).export }

    it 'includes a type' do
      expect(subject).to include('type' => 'PersonVictim')
    end

    it 'includes subclass-specific attributes' do
      expect(subject).to include(
        'date_of_birth' => '1980-08-01',
        'visually_recorded_interview' => false
      )
    end

    it 'includes a name object' do
      expect(subject).to include(
        'name' => include(
          'type' => 'PersonName',
          'given_name' => %w[ Jennie Claire ],
          'surname' => 'Jones'
        )
      )
    end

    context 'victim sub-document' do
      subject { super().fetch('victim') }

      it 'includes victim-specific fields' do
        expect(subject).to include(
          'witness_type' => ['other'],
          'victim_code_requirements_met' => true,
          'has_the_victim_made_a_vps_isb' => false
        )
      end

      context 'witness sub-sub-document' do
        subject { super().fetch('witness') }

        it 'includes witness-specific fields' do
          expect(subject).to eq(
            "nature_of_involvement" => "Nature of involvement",
            "evidence_they_can_give" => "Evidence they can give"
          )
        end
      end
    end
  end
end
