class CaseFilesController < ApplicationController
  def index
  end

  def create
    if params.key?(:case_file)
      @upload = CaseFileUpload.new(params[:case_file][:raw].read)
      if @upload.exception
        Rails.logger.error @upload.exception_log_string
        render status: :bad_request
      end
    else
      redirect_to action: :index
    end
  end
end
