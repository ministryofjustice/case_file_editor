class DateTimeExporter
  def initialize(value)
    @value = value
  end

  def export
    @value.iso8601
  end
end
