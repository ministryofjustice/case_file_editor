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

  it 'passes validation if all attributes are in the acceptable list' do
    subject.wotsit = %w[ OK ]
    expect(subject).to be_valid
  end

  it 'fails validation if an attribute is not in the acceptable list' do
    subject.wotsit = %w[ OK bad ]
    expect(subject).not_to be_valid
  end
end
