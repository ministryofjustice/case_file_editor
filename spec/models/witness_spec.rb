RSpec.describe Witness do
  let!(:case_file) {
    FirstHearingCaseFile.new(witnesses: [subject, other_witness])
  }
  let(:other_witness) { described_class.new(witness_id: 'ABC123') }

  context 'validations' do
    describe 'witness_id' do
      it 'is valid if unique in the file' do
        subject.witness_id = 'XYZ999'
        subject.validate
        expect(subject.errors).not_to have_key(:witness_id)
      end

      it 'is invalid if not unique in the file' do
        subject.witness_id = 'ABC123'
        subject.validate
        expect(subject.errors).to have_key(:witness_id)
      end
    end

    describe 'special_measures' do
      context 'when GAP' do
        before do
          allow(case_file).
            to receive(:not_guilty_anticipated_plea?).
            and_return(false)
        end

        it 'is invalid if present' do
          subject.special_measures = false
          subject.validate
          expect(subject.errors[:special_measures]).not_to be_empty
        end

        it 'is valid if absent' do
          subject.special_measures = nil
          subject.validate
          expect(subject.errors[:special_measures]).to be_empty
        end
      end

      context 'when NGAP' do
        before do
          allow(case_file).
            to receive(:not_guilty_anticipated_plea?).
            and_return(true)
        end

        it 'is valid if present' do
          subject.special_measures = false
          subject.validate
          expect(subject.errors[:special_measures]).to be_empty
        end

        it 'is invalid if absent' do
          subject.special_measures = nil
          subject.validate
          expect(subject.errors[:special_measures]).not_to be_empty
        end
      end
    end

    describe 'wish_to_use_video_link' do
      context 'when GAP' do
        before do
          allow(case_file).
            to receive(:not_guilty_anticipated_plea?).
            and_return(false)
        end

        it 'is invalid if present' do
          subject.wish_to_use_video_link = false
          subject.validate
          expect(subject.errors[:wish_to_use_video_link]).not_to be_empty
        end

        it 'is valid if absent' do
          subject.wish_to_use_video_link = nil
          subject.validate
          expect(subject.errors[:wish_to_use_video_link]).to be_empty
        end
      end

      context 'when NGAP' do
        before do
          allow(case_file).
            to receive(:not_guilty_anticipated_plea?).
            and_return(true)
        end

        it 'is valid if present' do
          subject.wish_to_use_video_link = false
          subject.validate
          expect(subject.errors[:wish_to_use_video_link]).to be_empty
        end

        it 'is invalid if absent' do
          subject.wish_to_use_video_link = nil
          subject.validate
          expect(subject.errors[:wish_to_use_video_link]).not_to be_empty
        end
      end
    end

    describe 'interpreter_required' do
      context 'when GAP' do
        before do
          allow(case_file).
            to receive(:not_guilty_anticipated_plea?).
            and_return(false)
        end

        it 'is invalid if present' do
          subject.interpreter_required = false
          subject.validate
          expect(subject.errors[:interpreter_required]).not_to be_empty
        end

        it 'is valid if absent' do
          subject.interpreter_required = nil
          subject.validate
          expect(subject.errors[:interpreter_required]).to be_empty
        end
      end

      context 'when NGAP' do
        before do
          allow(case_file).
            to receive(:not_guilty_anticipated_plea?).
            and_return(true)
        end

        it 'is valid if present' do
          subject.interpreter_required = false
          subject.validate
          expect(subject.errors[:interpreter_required]).to be_empty
        end

        it 'is invalid if absent' do
          subject.interpreter_required = nil
          subject.validate
          expect(subject.errors[:interpreter_required]).not_to be_empty
        end
      end
    end
  end

  describe 'officer_witness?' do
    it 'is true if the witness_type includes an officer' do
      subject.witness_type = %w[ eye police ]
      expect(subject).to be_officer_witness
    end

    it 'is false if the witness_type does not include an officer' do
      subject.witness_type = %w[ eye child ]
      expect(subject).not_to be_officer_witness
    end
  end
end
