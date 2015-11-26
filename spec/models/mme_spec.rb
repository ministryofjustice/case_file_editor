RSpec.describe Mme do
  context 'validations' do
    let!(:case_file) {
      CaseFile.new(
        multimedia_evidence: [subject, other_mme]
      )
    }
    let(:other_mme) { described_class.new(id: 'ABC123') }

    describe 'id' do
      it 'is valid if unique in the file' do
        subject.id = 'XYZ999'
        subject.validate
        expect(subject.errors).not_to have_key(:id)
      end

      it 'is invalid if not unique in the file' do
        subject.id = 'ABC123'
        subject.validate
        expect(subject.errors).to have_key(:id)
      end
    end

    describe 'relied_upon_trial' do
      context 'when relied_upon_sentence = true' do
        before do
          subject.relied_upon_sentence = true
        end

        it 'is valid if true' do
          subject.relied_upon_trial = true
          subject.validate
          expect(subject.errors).not_to have_key(:relied_upon_trial)
        end

        it 'is valid if false' do
          subject.relied_upon_trial = false
          subject.validate
          expect(subject.errors).not_to have_key(:relied_upon_trial)
        end
      end

      context 'when relied_upon_sentence = false' do
        before do
          subject.relied_upon_sentence = false
        end

        it 'is valid if true' do
          subject.relied_upon_trial = true
          subject.validate
          expect(subject.errors).not_to have_key(:relied_upon_trial)
        end

        it 'is invalid if false' do
          subject.relied_upon_trial = false
          subject.validate
          expect(subject.errors).to have_key(:relied_upon_trial)
        end
      end
    end

    describe 'relied_upon_sentence' do
      context 'when relied_upon_trial = true' do
        before do
          subject.relied_upon_trial = true
        end

        it 'is valid if true' do
          subject.relied_upon_sentence = true
          subject.validate
          expect(subject.errors).not_to have_key(:relied_upon_sentence)
        end

        it 'is valid if false' do
          subject.relied_upon_sentence = true
          subject.validate
          expect(subject.errors).not_to have_key(:relied_upon_sentence)
        end
      end

      context 'when relied_upon_trial = false' do
        before do
          subject.relied_upon_trial = false
        end

        it 'is valid if true' do
          subject.relied_upon_sentence = true
          subject.validate
          expect(subject.errors).not_to have_key(:relied_upon_sentence)
        end

        it 'is invalid if false' do
          subject.relied_upon_sentence = false
          subject.validate
          expect(subject.errors).to have_key(:relied_upon_sentence)
        end
      end
    end
  end
end
