class FileController < ApplicationController
  before_action :authenticate_user!

  def get
    outcome = FindFile.run(params.permit(:id, :file_name))
    if outcome.valid?
      send_data(outcome.file.read, filename: outcome.file_name_with_type)
    else
      respond_to do |format|
        format.html {
          render body: '', status: 422, content_type: 'text/html'
        }
        format.json {
          render json: outcome.errors.messages, status: 422
        }
      end
    end
  end

  def get_all;
  end
end
