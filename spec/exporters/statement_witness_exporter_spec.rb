RSpec.describe StatementWitnessExporter do
  let(:witness) {
    StatementWitness.new(
      witness_type: ['eye'],
      name: PersonName.new(
        given_name: ['Jennie', 'Claire'],
        surname: 'Jones'
      ),
      nature_of_involvement: 'Nature of involvement',
      evidence_they_can_give: 'Evidence they can give',
      date_of_birth: Date.new(1980, 8, 1),
      visually_recorded_interview: false
    )
  }

  context 'exported hash' do
    subject { described_class.new(witness).export }

    it 'includes a type' do
      expect(subject).to include('type' => 'StatementWitness')
    end

    it 'includes subclass-specific attributes' do
      expect(subject).to include(
        'witness_type' => ['eye'],
        'date_of_birth' => '1980-08-01',
        'visually_recorded_interview' => false
      )
    end

    it 'includes a name object' do
      expect(subject).to include(
        'name' => include(
          'given_name' => %w[ Jennie Claire ],
          'surname' => 'Jones'
        )
      )
    end

    context 'witness sub-document' do
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
