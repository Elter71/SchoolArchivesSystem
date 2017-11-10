class FileController < ApplicationController
  before_action :authenticate_user!

  def get
    outcome = FindFile.run(params.permit(:id, :file_name))
    if outcome.valid?
      send_data(outcome.file.read, filename: outcome.file_name_with_type)
    else
      respond_to do |format|
        format.html {render body: '', status: 422, content_type: 'text/html'}
        format.json {render json: outcome.errors.messages, status: 422}
      end
    end
  end

  def get_all
    outcome = FindFiles.run(params.permit(:id))
    if outcome.valid?
      render json: outcome.files_name
    else
      render json: outcome.errors.messages, status: 422
    end
  end

  def get_all_image
    outcome = FindGalleryFiles.run(params.permit(:id))
    if outcome.valid?
      render json: outcome.files_name
    else
      render json: outcome.errors.messages, status: 422
    end
  end

  def download_all_files
   
  end
end
