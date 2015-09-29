class CaseFileUpload
  def initialize(json)
    @case = FileIngester.new.ingest(json)
    if @case
      @errors = RecursiveValidator.new(@case).errors
    end
  rescue StandardError => ex
    @exception = ex
  end

  attr_reader :case, :errors, :exception
end
