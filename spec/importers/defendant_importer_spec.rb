require 'rails_helper'

RSpec.describe DefendantImporter do
  subject {
    described_class.new(source).import
  }

  context 'with MME' do
    let(:source) {
      {
        'multimedia_evidence_response' => [
          {
            'id' => '1',
            'type' => 'MmeRecordedResponse',
            'defendant_shown' => true,
            'defendant_comments_if_shown' => 'These are the defendant comments if shown.',
            'is_defendant_believed_to_be_in_the_mme' => true,
            'defendant_admits_being_in_mme' => true
          }
        ]
      }
    }

    describe 'multimedia_evidence_recorded_responses' do
      subject { super().multimedia_evidence_recorded_responses }

      it 'has one element' do
        expect(subject.length).to eq(1)
      end

      describe 'first' do
        subject { super().first }

        it 'is an MmeRecordedResponse' do
          expect(subject).to be_kind_of(MmeRecordedResponse)
        end

        it 'has all the fields in the source' do
          expect(subject.defendant_shown).
            to be_truthy
          expect(subject.defendant_comments_if_shown).
            to eq('These are the defendant comments if shown.')
          expect(subject.is_defendant_believed_to_be_in_the_mme).
            to be_truthy
          expect(subject.defendant_admits_being_in_mme).
            to be_truthy
        end
      end
    end

    describe 'multimedia_evidence_not_recorded_response' do
      subject { super().multimedia_evidence_not_recorded_response }

      it 'is nil' do
        expect(subject).to be_nil
      end
    end
  end

  context 'without MME' do
    let(:source) {
      {
        'multimedia_evidence_response' => {
          'type' => 'MmeNotRecordedResponse',
          'defendant_admitted_to_location' => true,
          'how_is_identification_established' => 'distinctive facial tattoos'
        }
      }
    }

    describe 'multimedia_evidence_recorded_responses' do
      subject { super().multimedia_evidence_recorded_responses }

      it 'is empty' do
        expect(subject).to be_empty
      end
    end

    describe 'multimedia_evidence_not_recorded_response' do
      subject { super().multimedia_evidence_not_recorded_response }

      it 'is an MmeNotRecordedResponse' do
        expect(subject).to be_kind_of(MmeNotRecordedResponse)
      end

      it 'has all the fields in the source' do
        expect(subject.defendant_admitted_to_location).to be_truthy
        expect(subject.how_is_identification_established).
          to eq('distinctive facial tattoos')
      end
    end
  end

  context 'without an MME entry' do
    let(:source) { {} }

    describe 'multimedia_evidence_recorded_responses' do
      subject { super().multimedia_evidence_recorded_responses }

      it 'is empty' do
        expect(subject).to be_empty
      end
    end

    describe 'multimedia_evidence_not_recorded_response' do
      subject { super().multimedia_evidence_not_recorded_response }

      it 'is empty' do
        expect(subject).to be_nil
      end
    end
  end
end
