RSpec.describe Property do
  subject { described_class.new }

  describe 'damaged?' do
    it 'is true if property_action is damaged' do
      subject.property_action = 'damaged'
      expect(subject).to be_damaged
    end

    it 'is true if property_action is stolen_recovered_damaged' do
      subject.property_action = 'stolen_recovered_damaged'
      expect(subject).to be_damaged
    end

    it 'is false if property_action is something else' do
      subject.property_action = 'stolen_not_recovered'
      expect(subject).not_to be_damaged
    end
  end

  describe 'recovered?' do
    it 'is true if property_action is stolen_recovered' do
      subject.property_action = 'stolen_recovered'
      expect(subject).to be_recovered
    end

    it 'is true if property_action is stolen_recovered_damaged' do
      subject.property_action = 'stolen_recovered_damaged'
      expect(subject).to be_recovered
    end

    it 'is false if property_action is something else' do
      subject.property_action = 'stolen_not_recovered'
      expect(subject).not_to be_recovered
    end
  end
end
