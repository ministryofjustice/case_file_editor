require 'rails_helper'

module RecursiveValidatorSpec
  class Child
    include Virtus.model
    include ActiveModel::Validations

    attribute :name, String
    validates :name, presence: true
  end

  class Parent
    include Virtus.model
    include ActiveModel::Validations

    attribute :children, Array[Child]
    attribute :child, Child
    attribute :name, String
    validates :name, presence: true
  end
end

RSpec.describe RecursiveValidator do
  let(:structure) {
    RecursiveValidatorSpec::Parent.new(
      name: 'parent',
      children: [
        RecursiveValidatorSpec::Child.new(name: 'child 1')
      ],
      child: RecursiveValidatorSpec::Child.new(name: 'child 2')
    )
  }

  subject {
    described_class.new(structure)
  }

  context 'with no errors' do
    it 'returns an empty hash' do
      expect(subject.errors).to eq({})
    end
  end

  context 'with top-level errors' do
    it 'lists errors by field' do
      structure.name = nil
      expect(subject.errors).to eq(name: ["can't be blank"])
    end
  end

  context 'with errors in an attribute' do
    it 'lists errors by field in a nested hash' do
      structure.child.name = nil
      expect(subject.errors).to eq(
        child: { name: ["can't be blank"] }
      )
    end
  end

  context 'with errors in an array attribute element' do
    it 'lists errors by field in a nested hash' do
      structure.children.first.name = nil
      expect(subject.errors).to eq(
        children: { 0 => { name: ["can't be blank"] } }
      )
    end
  end
end
