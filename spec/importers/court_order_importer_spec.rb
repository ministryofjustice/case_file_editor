require 'rails_helper'

RSpec.describe CourtOrderImporter do
  let(:source) {
    {
      'court_order_title' => { 'court_order_title' => 'confiscation_order' },
      'reason_for_the_request' => 'These are the reasons for request 2',
      'draft_conditions' => ['Condition 1', 'Condition 2']
    }
  }

  subject {
    described_class.new(source).import
  }

  it 'creates a CourtOrder' do
    expect(subject).to be_kind_of(CourtOrder)
  end

  it 'imports the title from within a nested hash' do
    expect(subject.court_order_title).to eq('confiscation_order')
  end
end
