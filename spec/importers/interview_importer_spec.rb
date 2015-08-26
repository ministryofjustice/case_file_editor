require 'rails_helper'

RSpec.describe InterviewImporter do
  subject {
    described_class.importer(source).import
  }

  context 'imported standard interview' do
    let(:source) {
      { "type" => "StandardInterview" }
    }

    it { is_expected.to be_kind_of(StandardInterview) }
  end

  context 'imported "not interviewed" record' do
    let(:source) {
      { 'reason' => 'just because' }
    }

    it { is_expected.to be_kind_of(NotInterviewed) }
  end
end
