class MmeResponseImporter < TypeBasedImporter
  def self.importer_class
    {
      'MmeRecordedResponse' => MmeRecordedResponseImporter,
      'MmeNotRecordedResponse' => MmeNotRecordedResponseImporter
    }
  end
end
