RSpec.describe CaseFileUpload do
  context 'with valid JSON' do
    subject { described_class.new('{}') }

    it 'has a case' do
      expect(subject.case).to be_a(Case)
    end

    it 'has no exception' do
      expect(subject.exception).to be_nil
    end

    it 'has validation errors' do
      expect(subject.object_errors).to include(pti_urn: ["is invalid"])
    end

    it 'has schema errors' do
      expect(subject.schema_errors).to be_a(Array)
    end
  end

  context 'with invalid JSON' do
    subject { described_class.new('!@#@#$') }

    it 'has no case' do
      expect(subject.case).to be_nil
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
