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
    # Unfortunately, Virtus doesn't expose field names via its API
    klass.attribute_set.instance_variable_get('@index').
      select { |name, _| name.kind_of?(Symbol) }.
      map { |name, attr| Field.new(name, *decode_attr(attr)) }
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
