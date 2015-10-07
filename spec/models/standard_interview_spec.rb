RSpec.describe StandardInterview do
  context 'validations' do
    describe 'appropriate_adults' do
      context 'when defendant is a youth' do
        it 'is valid if present' do
          subject.appropriate_adults = [PersonName.new]
          subject.validate
          subject.validate_as_youth
          expect(subject.errors[:appropriate_adults]).to be_empty
        end

        it 'is invalid if absent' do
          subject.validate
          subject.validate_as_youth
          expect(subject.errors[:appropriate_adults]).not_to be_empty
        end
      end

      context 'when defendant is an adult' do
        it 'is valid if present' do
          subject.appropriate_adults = [PersonName.new]
          subject.validate
          expect(subject.errors[:appropriate_adults]).to be_empty
        end

        it 'is valid if absent' do
          subject.validate
          expect(subject.errors[:appropriate_adults]).to be_empty
        end
      end
    end
  end
end
