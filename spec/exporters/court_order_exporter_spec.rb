require 'rails_helper'

RSpec.describe CourtOrderExporter do
  let(:court_order) {
    CourtOrder.new(
      court_order_title: 'confiscation_order',
      reason_for_the_request: 'These are the reasons for request 2',
      draft_conditions: ['Condition 1', 'Condition 2']
    )
  }

  context 'exported hash' do
    subject {
      described_class.new(court_order).export
    }

    it 'has all the attributes of the object' do
      expect(subject).to include(
        'court_order_title' => 'confiscation_order',
        'reason_for_the_request' => 'These are the reasons for request 2',
        'draft_conditions' => ['Condition 1', 'Condition 2']
      )
    end
  end
end
