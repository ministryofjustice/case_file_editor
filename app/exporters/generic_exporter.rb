class GenericExporter
  def self.attributes(*names)
    @attributes ||= []
    @attributes += names
    @attributes
  end

  def initialize(object)
    @object = object
  end

  def export
    self.class.attributes.map { |name|
      [name, exporter(@object.public_send(name)).export]
    }.to_h
  end

private

  def exporter(object)
    "#{object.class}Exporter".constantize.new(object)
  end
end
