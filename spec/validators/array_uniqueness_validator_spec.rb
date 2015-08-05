require 'rails_helper'

RSpec.describe ArrayUniquenessValidator do
  let(:klass) {
    Class.new do
      include Virtus.model
      include ActiveModel::Validations

      attribute :wotsit, Array[String]
      validates :wotsit,
        array_uniqueness: true
    end
  }

  subject { klass.new }

  it 'passes validation if all attributes are unique' do
    subject.wotsit = ['This is OK', 'This is also OK']
    expect(subject).to be_valid
  end

  it 'fails validation if an attribute is repeated' do
    subject.wotsit = ['This is OK', 'This is bad', 'This is bad']
    expect(subject).not_to be_valid
  end
end
