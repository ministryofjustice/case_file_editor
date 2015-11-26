RSpec.describe MmeRecordedResponse do
  context 'validations' do
    let!(:case_file) {
      FirstHearingCaseFile.new(
        defendants: [
          Defendant.new(
            multimedia_evidence_response: [subject]
          )
        ],
        multimedia_evidence: [Mme.new(id: 'ABC123')]
      )
    }

    context 'id' do
      it 'is valid if it refers to an Mme ID' do
        subject.id = 'ABC123'
        subject.validate
        expect(subject.errors[:id]).to be_empty
      end

      it 'is invalid if it does not refer to an Mme ID' do
        subject.id = 'XYZ999'
        subject.validate
        expect(subject.errors[:id]).not_to be_empty
      end
    end
  end
end
