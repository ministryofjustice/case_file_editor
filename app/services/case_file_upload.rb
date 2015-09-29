require 'json_schema'

class CaseFileUpload
  def initialize(json_string)
    json = JsonIngester.new.ingest(json_string)
    @case = CaseImporter.new(json).import
    @object_errors = validate_objects(@case) if @case
    @schema_errors = validate_schema(json)
  rescue StandardError => ex
    @exception = ex
  end

  attr_reader :case, :object_errors, :schema_errors, :exception

  def object_errors?
    object_errors && object_errors.any?
  end

  def schema_errors?
    schema_errors && schema_errors.any?
  end

  def errors?
    object_errors? || schema_errors?
  end

private

  def validate_objects(obj)
    RecursiveValidator.new(obj).errors
  end

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
