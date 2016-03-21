RSpec.describe DomesticViolence do
  context 'validations' do
    let(:victim) {
      PersonVictim.new(
        name: PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
      )
    }

    let(:defendant) {
      Defendant.new(domestic_violence: [subject])
    }

    let!(:case) {
      Case.new(
        defendants: [defendant],
        witnesses: [victim]
      )
    }

    it 'is valid if the victim name matches a victim' do
      subject.victim_name =
        PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
      subject.validate
      expect(subject.errors[:victim_name]).to be_empty
    end

    it 'is invalid if the victim name does not match a victim' do
      subject.victim_name =
        PersonName.new(surname: 'Jones', given_name: %w[ Bob ])
      subject.validate
      expect(subject.errors[:victim_name]).not_to be_empty
    end
  end
end
