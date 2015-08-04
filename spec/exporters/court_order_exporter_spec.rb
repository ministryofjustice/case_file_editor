require 'rails_helper'

RSpec.describe CourtOrderExporter do
  let(:court_order) {
    CourtOrder.new(
      court_order_title: 'confiscation_order',
      reason_for_the_request: 'These are the reasons for request 2',
      draft_conditions: ['Condition 1', 'Condition 2']
    )
  }

  subject {
    described_class.new(court_order).export
  }

  it 'generates a court_order_title structure' do
    expect(subject['court_order_title']).
      to eq('court_order_title' => 'confiscation_order')
  end
end
