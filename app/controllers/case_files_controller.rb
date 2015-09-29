class CaseFilesController < ApplicationController
  def index
  end

  def create
    if params.key?(:case_file)
      @upload = CaseFileUpload.new(params[:case_file][:raw].read)
    else
      redirect_to action: :index
    end
  end
end
