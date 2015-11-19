RSpec.describe Victim do
  context 'validations' do
    let!(:case_file) { Case.new(witnesses: [subject]) }

    describe 'is_retraction_statement' do
      context 'when DV' do
        before do
          allow(case_file).to receive(:domestic_violence?).and_return(true)
        end

        it 'is invalid if nil' do
          subject.is_retraction_statement = nil
          subject.validate
          expect(subject.errors[:is_retraction_statement]).not_to be_empty
        end

        it 'is valid if present' do
          subject.is_retraction_statement = false
          subject.validate
          expect(subject.errors[:is_retraction_statement]).to be_empty
        end
      end

      context 'when not DV' do
        before do
          allow(case_file).to receive(:domestic_violence?).and_return(false)
        end

        it 'is valid if present' do
          subject.is_retraction_statement = true
          subject.validate
          expect(subject.errors[:is_retraction_statement]).to be_empty
        end

        it 'is valid if nil' do
          subject.is_retraction_statement = nil
          subject.validate
          expect(subject.errors[:is_retraction_statement]).to be_empty
        end
      end
    end
  end
end
