require 'rails_helper'

RSpec.describe DateTimeExporter do
  it 'gives the time in UTC as YYYY-MM-DDTHH:MMZ' do
    dt = ActiveSupport::TimeZone.new('Fiji').local(2015, 8, 4, 11, 00)
    expect(described_class.new(dt).export).to eq('2015-08-03T23:00Z')
  end
end
