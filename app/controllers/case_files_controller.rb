class CaseFilesController < ApplicationController
  def index
  end

  def create
    @upload = CaseFileUpload.new(params[:case_file][:raw].read)
  end
end
