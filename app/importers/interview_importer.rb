class InterviewImporter < GenericImporter
  def self.importer(source)
    if source['type'] == 'StandardInterview'
      StandardInterviewImporter.new(source)
    else
      NotInterviewedImporter.new(source)
    end
  end
end
