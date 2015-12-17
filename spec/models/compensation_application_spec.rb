RSpec.describe CompensationApplication do
  describe 'other_expenses?' do
    it 'is true if reasons for application include other_expenses' do
      subject.reasons_for_application << 'other_expenses'
      expect(subject).to be_other_expenses
    end

    it 'is false otherwise' do
      expect(subject).not_to be_other_expenses
    end
  end

  describe 'other_losses?' do
    it 'is true if reasons for application include other_losses' do
      subject.reasons_for_application << 'other_losses'
      expect(subject).to be_other_losses
    end

    it 'is false otherwise' do
      expect(subject).not_to be_other_losses
    end
  end

  describe 'validations' do
    let!(:case_file) {
      CaseFile.new(
        defendants: [
          Defendant.new(
            name: PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
          )
        ],
        witnesses: [
          PersonVictim.new(
            compensation_applications: [subject]
          )
        ]
      )
    }

    it 'is valid when the defendant_names matches a defendant' do
      subject.defendant_names = [
        PersonName.new(surname: 'Smith', given_name: %w[ Bob ])
      ]
      skip 'Not yet updated to 1.2.0'
      subject.validate
      expect(subject.errors[:defendant_names]).to be_empty
    end

    it 'is invalid when the defendant_names does not match a defendant' do
      subject.defendant_names = [
        PersonName.new(surname: 'Jones', given_name: %w[ Bob ])
      ]
      skip 'Not yet updated to 1.2.0'
      subject.validate
      expect(subject.errors[:defendant_names]).not_to be_empty
    end
  end
end
