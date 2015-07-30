class ArrayExporter < GenericExporter
  def initialize(ary)
    @ary = ary
  end

  def export
    @ary.map { |a| exporter(a).export }
  end
end
