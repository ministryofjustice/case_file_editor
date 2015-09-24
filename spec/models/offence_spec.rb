RSpec.describe Offence do
  describe 'anticipated_guilty_plea?' do
    it 'is true if anticipated plea is guilty' do
      subject.anticipated_plea = 'guilty'
      expect(subject).to be_anticipated_guilty_plea
    end

    it 'is false if anticipated pleas is not guilty' do
      subject.anticipated_plea = 'not_guilty'
      expect(subject).not_to be_anticipated_guilty_plea
    end
  end
end
