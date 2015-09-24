RSpec.describe PersonVictim do
  describe 'victim_to_read?' do
    it 'is true if victim wishes to attend court and read' do
      subject.victim_wish_to_attend_court = 'yes_victim_to_read'
      expect(subject).to be_victim_to_read
    end

    it 'is false otherwise' do
      expect(subject).not_to be_victim_to_read
    end
  end
end
