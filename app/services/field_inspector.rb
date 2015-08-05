class FieldInspector
  Field = Struct.new(:name, :cardinality, :type) do
    def array?
      cardinality == :many
    end

    def basic?
      type.is_a?(Symbol)
    end
  end

  def fields(klass)
    klass.attribute_set.map { |a| Field.new(a.name, *decode_attr(a)) }
  end

private

  def decode_attr(attr)
    case attr
    when Virtus::Attribute::Collection
      [:many, decode_attr(attr.send(:member_type)).last]
    when Virtus::Attribute::Boolean
      [:one, :boolean]
    when Virtus::Attribute::EmbeddedValue
      [:one, attr.primitive]
    when Virtus::Attribute
      [:one, attr.primitive.to_s.downcase.to_sym]
    end
  end
end
