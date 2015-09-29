class SchemaValidator
  def initialize(json)
    @json = json
  end

  def errors
    root = {}
    validate_schema(@json).each do |err|
      node = err.path[1..-2].inject(root) { |a, e| a[e] ||= {} }
      node[err.path.last] ||= []
      node[err.path.last] << err.message
    end
    root
  end

private

  def validate_schema(json)
    schema = JsonSchema.parse!(JSON.parse(File.read(schema_path)))
    schema.expand_references!
    validator = JsonSchema::Validator.new(schema)
    validator.validate json
    validator.errors
  end

  def schema_path
    File.expand_path('../../schemas/first-hearing.schema.json', __FILE__)
  end
end
