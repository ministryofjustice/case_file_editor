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

  def exception_log_string
    ([@exception.inspect] + @exception.backtrace).join("\n")
  end

private

  def validate_objects(obj)
    RecursiveValidator.new(obj).errors
  end

  def validate_schema(json)
    SchemaValidator.new(json).errors
  end
end
