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
end
