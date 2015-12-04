require 'rails_helper'

RSpec.describe SchemaValidator do
  subject { described_class.new(hash) }

  context 'with a First Hearing case file' do
    let(:hash) { { 'type' => 'FirstHearingDCF' } }

    it 'validates against the First Hearing schema' do
      expect(subject.errors.to_s).to match(/property/)
    end
  end

  context 'with a Breach of Bail case file' do
    let(:hash) { { 'type' => 'BobDCF' } }

    it 'validates against the Breach of Bail schema' do
      expect(subject.errors.to_s).not_to match(/property/)
    end
  end
end
