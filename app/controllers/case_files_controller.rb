class CaseFilesController < ApplicationController
  def index
  end

  def create
    @case = FileIngester.new.ingest(params[:case_file][:raw].read)
    if @case
      @errors = RecursiveValidator.new(@case).errors
    end
  rescue StandardError => ex
    @exception = ex
  end
end
