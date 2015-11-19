RSpec.describe Property do
  let!(:case_file) {
    Case.new(property: [subject, other_property])
  }
  let(:other_property) { described_class.new(property_id: 'ABC123') }

  describe 'validations' do
    describe 'property_id' do
      it 'is valid if unique in the file' do
        subject.property_id = 'XYZ999'
        subject.validate
        expect(subject.errors).not_to have_key(:property_id)
      end

      it 'is invalid if not unique in the file' do
        subject.property_id = 'ABC123'
        subject.validate
        expect(subject.errors).to have_key(:property_id)
      end
    end
  end

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
