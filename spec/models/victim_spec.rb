RSpec.describe Victim do
  context 'validations' do
    describe 'is_retraction_statement' do
      context 'when DV' do
        it 'is invalid if nil' do
          subject.is_retraction_statement = nil
          subject.validate_domestic_violence_specific(true)
          expect(subject.errors[:is_retraction_statement]).not_to be_empty
        end

        it 'is valid if present' do
          subject.is_retraction_statement = false
          subject.validate_domestic_violence_specific(true)
          expect(subject.errors[:is_retraction_statement]).to be_empty
        end
      end

      context 'when not DV' do
        it 'is valid if present' do
          subject.is_retraction_statement = true
          subject.validate_domestic_violence_specific(false)
          expect(subject.errors[:is_retraction_statement]).to be_empty
        end

        it 'is valid if nil' do
          subject.is_retraction_statement = nil
          subject.validate_domestic_violence_specific(false)
          expect(subject.errors[:is_retraction_statement]).to be_empty
        end
      end
    end
  end
end
