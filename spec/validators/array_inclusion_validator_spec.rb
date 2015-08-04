require 'rails_helper'

RSpec.describe ArrayInclusionValidator do
  let(:klass) {
    Class.new do
      include Virtus.model
      include ActiveModel::Validations

      attribute :wotsit, Array[String]
      validates :wotsit,
        array_inclusion: { in: ['OK', 'Also fine'] }
    end
  }

  subject { klass.new }

  it 'passes validation if the attribute is in the acceptable list' do
    subject.wotsit = 'OK'
    expect(subject).to be_valid
  end

  it 'fails validation if the attribute is missing' do
    subject.wotsit = nil
    expect(subject).to be_valid
  end

  it 'fails validation if the attribute is not in the acceptable list' do
    subject.wotsit = 'something else'
    expect(subject).not_to be_valid
  end
end
