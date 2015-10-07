RSpec.describe Witness do
  context 'validations' do
    describe 'special_measures' do
      context 'when GAP' do
        it 'is invalid if present' do
          subject.special_measures = false
          subject.validate_gap_specific true
          expect(subject.errors[:special_measures]).not_to be_empty
        end

        it 'is valid if absent' do
          subject.special_measures = nil
          subject.validate_gap_specific true
          expect(subject.errors[:special_measures]).to be_empty
        end
      end

      context 'when NGAP' do
        it 'is valid if present' do
          subject.special_measures = false
          subject.validate_gap_specific false
          expect(subject.errors[:special_measures]).to be_empty
        end

        it 'is invalid if absent' do
          subject.special_measures = nil
          subject.validate_gap_specific false
          expect(subject.errors[:special_measures]).not_to be_empty
        end
      end
    end

    describe 'wish_to_use_video_link' do
      context 'when GAP' do
        it 'is invalid if present' do
          subject.wish_to_use_video_link = false
          subject.validate_gap_specific true
          expect(subject.errors[:wish_to_use_video_link]).not_to be_empty
        end

        it 'is valid if absent' do
          subject.wish_to_use_video_link = nil
          subject.validate_gap_specific true
          expect(subject.errors[:wish_to_use_video_link]).to be_empty
        end
      end

      context 'when NGAP' do
        it 'is valid if present' do
          subject.wish_to_use_video_link = false
          subject.validate_gap_specific false
          expect(subject.errors[:wish_to_use_video_link]).to be_empty
        end

        it 'is invalid if absent' do
          subject.wish_to_use_video_link = nil
          subject.validate_gap_specific false
          expect(subject.errors[:wish_to_use_video_link]).not_to be_empty
        end
      end
    end

    describe 'interpreter_required' do
      context 'when GAP' do
        it 'is invalid if present' do
          subject.interpreter_required = false
          subject.validate_gap_specific true
          expect(subject.errors[:interpreter_required]).not_to be_empty
        end

        it 'is valid if absent' do
          subject.interpreter_required = nil
          subject.validate_gap_specific true
          expect(subject.errors[:interpreter_required]).to be_empty
        end
      end

      context 'when NGAP' do
        it 'is valid if present' do
          subject.interpreter_required = false
          subject.validate_gap_specific false
          expect(subject.errors[:interpreter_required]).to be_empty
        end

        it 'is invalid if absent' do
          subject.interpreter_required = nil
          subject.validate_gap_specific false
          expect(subject.errors[:interpreter_required]).not_to be_empty
        end
      end
    end
  end
end
