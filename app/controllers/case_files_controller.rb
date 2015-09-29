class CaseFilesController < ApplicationController
  def index
  end

  def create
    upload = CaseFileUpload.new(params[:case_file][:raw].read)
    @case = upload.case
    @errors = upload.errors
    @exception = upload.exception
  end
end
