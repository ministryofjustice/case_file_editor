RSpec.describe NgapOtherWitnessExporter do
  let(:witness) {
    NgapOtherWitness.new(
      witness_type: ['eye'],
      name: PersonName.new(
        given_name: ['Jennie', 'Claire'],
        surname: 'Jones'
      ),
      nature_of_involvement: 'Nature of involvement',
      evidence_they_can_give: 'Evidence they can give',
      number: 'ABC123',
      rank: 'Sergeant'
    )
  }

  context 'exported hash' do
    subject { described_class.new(witness).export }

    it 'includes a type' do
      expect(subject).to include('type' => 'NgapOtherWitness')
    end

    it 'includes subclass-specific attributes' do
      expect(subject).to include(
        'witness_type' => ['eye'],
        'number' => 'ABC123',
        'rank' => 'Sergeant'
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
