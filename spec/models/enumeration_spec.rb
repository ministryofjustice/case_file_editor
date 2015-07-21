require 'rails_helper'
require 'enumeration'

RSpec.describe Enumeration do
  class EnumerationTestClass < Enumeration
    self.values = %w[ foo bar ]
  end

  it 'is valid if value is in the list of values' do
    subject = EnumerationTestClass.new(value: 'foo')
    expect(subject).to be_valid
  end

  it 'is not valid if value is in the list of values' do
    subject = EnumerationTestClass.new(value: 'baz')
    expect(subject).not_to be_valid
  end
end
