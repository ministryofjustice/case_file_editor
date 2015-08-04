class DateTimeExporter
  def initialize(value)
    @value = value
  end

  def export
    @value.utc.strftime('%FT%RZ')
  end
end
