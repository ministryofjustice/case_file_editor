require 'rails_helper'

RSpec.describe InterviewImporter do
  subject {
    described_class.importer(source).import
  }

  context 'standard interview' do
    let(:source) {
      { "type" => "StandardInterview" }
    }

    it 'imports a standard interview' do
      expect(subject).to be_kind_of(StandardInterview)
    end
  end

  context 'not interviewed' do
    let(:source) {
      { 'reason' => 'just because' }
    }

    it 'imports a not interviewed object' do
      expect(subject).to be_kind_of(NotInterviewed)
    end
  end
end
