
class RecursiveValidator
  def initialize(root)
    @root = root
  end

  def errors
    node_errors(@root)
  end

private

  def node_errors(node)
    return {} unless node.respond_to?(:valid?)

    node.valid?
    node.attributes.inject(node.errors.messages) { |acc, (key, value)|
      acc.merge(attribute_errors(key, value))
    }
  end

  def attribute_errors(key, value)
    return array_attribute_errors(key, value) if value.respond_to?(:each)

    errs = node_errors(value)
    if errs.any?
      { key => errs }
    else
      {}
    end
  end

  def array_attribute_errors(key, value)
    {}.tap { |acc|
      value.map.with_index do |v, i|
        errs = node_errors(v)
        if errs.any?
          acc[key] ||= {}
          acc[key][i] = errs
        end
      end
    }
  end
end
