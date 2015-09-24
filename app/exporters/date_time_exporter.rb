require 'active_support/core_ext/date_time/calculations.rb'

class DateTimeExporter
  def initialize(value)
    @value = value
  end

  def export
    @value.utc.strftime('%FT%RZ')
  end
end
