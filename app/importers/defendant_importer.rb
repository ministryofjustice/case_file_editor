class DefendantImporter < GenericImporter
  def params
    super.merge(mme_response)
  end

  def mme_response
    obj = source['multimedia_evidence_response']
    case obj
    when Hash
      { multimedia_evidence_not_recorded_response: not_recorded_response(obj) }
    when Array
      { multimedia_evidence_recorded_responses: recorded_responses(obj) }
    else
      {}
    end
  end

  def recorded_responses(ary)
    ary.map { |obj|
      MmeRecordedResponseImporter.new(obj).import
    }
  end

  def not_recorded_response(obj)
    MmeNotRecordedResponseImporter.new(obj).import
  end
end
