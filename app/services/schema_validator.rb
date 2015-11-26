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
    case @json.fetch('type')
    when 'FirstHearingDCF'
      expand_path('first-hearing.schema.json')
    when 'BobDCF'
      expand_path('breach-of-bail.schema.json')
    end
  end

  def expand_path(filename)
    File.expand_path("../../schemas/#{filename}", __FILE__)
  end
end
