RSpec.describe Mme do
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
