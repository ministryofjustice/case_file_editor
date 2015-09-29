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

  context 'validations' do
    describe 'demeanour_at_incident' do
      context 'when DV' do
        it 'is invalid if nil' do
          subject.demeanour_at_incident = nil
          subject.validate_domestic_violence_specific(true)
          expect(subject.errors[:demeanour_at_incident]).not_to be_empty
        end

        it 'is valid if present' do
          subject.demeanour_at_incident = 'foo'
          subject.validate_domestic_violence_specific(true)
          expect(subject.errors[:demeanour_at_incident]).to be_empty
        end
      end

      context 'when not DV' do
        it 'is invalid if present' do
          subject.demeanour_at_incident = 'foo'
          subject.validate_domestic_violence_specific(false)
          expect(subject.errors[:demeanour_at_incident]).not_to be_empty
        end

        it 'is valid if nil' do
          subject.demeanour_at_incident = nil
          subject.validate_domestic_violence_specific(false)
          expect(subject.errors[:demeanour_at_incident]).to be_empty
        end
      end
    end
  end
end
