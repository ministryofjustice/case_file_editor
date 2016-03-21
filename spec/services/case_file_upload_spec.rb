RSpec.describe CaseFileUpload do
  subject { described_class.new(json) }

  context 'with valid First Hearing JSON' do
    let(:json) { '{"case": {"type": "FirstHearingDCF"} }' }

    it 'has a case_file' do
      expect(subject.case_file.case).to be_a(FirstHearingCaseFile)
    end

    it 'has no exception' do
      expect(subject.exception).to be_nil
    end

    it 'has validation errors' do
      expect(subject.object_errors).to include(schema_version:["Must be present"])
    end

    it 'has schema errors' do
      expect(subject.schema_errors).to be_a(Hash)
    end
  end

  context 'with a Breach of Bail case file' do
    let(:json) { '{"case": {"type": "BobDCF"} }' }

    it 'has a case_file' do
      expect(subject.case_file.case).to be_a(BreachOfBailCaseFile)
    end

    it 'has no exception' do
      expect(subject.exception).to be_nil
    end

    it 'has validation errors' do
      expect(subject.object_errors).to include(schema_version:["Must be present"])
    end

    it 'has schema errors' do
      expect(subject.schema_errors).to be_a(Hash)
    end
  end

  context 'with invalid JSON' do
    let(:json) { '!@#@#$' }

    it 'has no case_file' do
      expect(subject.case_file).to be_nil
    end

    it 'has an exception' do
      expect(subject.exception).to be_a(StandardError)
    end

    it 'has no validation errors' do
      expect(subject.object_errors).to be_nil
    end

    it 'has no schema errors' do
      expect(subject.schema_errors).to be_nil
    end
  end
end
