require 'spec_helper'
require 'virtus'
require 'field_inspector'

RSpec.describe FieldInspector do
  module FieldInspectorSpec
    class Bar
      include Virtus.model

      attribute :a, String
    end

    class Foo
      include Virtus.model

      attribute :a, String
      attribute :b, Boolean
      attribute :c, DateTime
      attribute :d, Date
      attribute :e, Bar
      attribute :f, Array[String]
      attribute :g, Array[Bar]
    end
  end

  subject {
    described_class.new.fields(FieldInspectorSpec::Foo)
  }

  describe 'name' do
    it 'gives attribute names as symbols' do
      expect(subject.map(&:name)).to eq(%i[ a b c d e f g ])
    end
  end

  describe 'type' do
    it 'gives non-Virtus types as symbols' do
      expect(subject.take(4).map(&:type)).
        to eq([:string, :boolean, :datetime, :date])
    end

    it 'gives Virtus types as themselves' do
      expect(subject[4].type).to eq(FieldInspectorSpec::Bar)
    end

    it 'gives non-Virtus array types as symbols' do
      expect(subject[5].type).to eq(:string)
    end

    it 'gives Virtus array types as themselves' do
      expect(subject[6].type).to eq(FieldInspectorSpec::Bar)
    end
  end

  describe 'cardinality' do
    it 'is :one for singular attributes' do
      expect(subject.take(5).map(&:cardinality)).to eq([:one] * 5)
    end

    it 'is :many for array attributes' do
      expect(subject.drop(5).map(&:cardinality)).to eq([:many] * 2)
    end
  end

  describe 'array?' do
    it 'is true iff cardinality is :many' do
      expect(subject.map(&:array?)).
        to eq([false, false, false, false, false, true, true])
    end
  end

  describe 'basic?' do
    it 'is false iff attribute is a Virtus type' do
      expect(subject.map(&:basic?)).
        to eq([true, true, true, true, false, true, false])
    end
  end
end
