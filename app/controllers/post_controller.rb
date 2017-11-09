class PostController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def get
    outcome = FindPost.run(params)
    if outcome.valid?
      respond_to do |format|
        @post = outcome.result
        format.html {
          render :get
        }
        format.json {
          render json: @post
        }
      end
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

  def create
    outcome = CreatePost.run(params.require(:post).merge(user_id: current_user.id))
    if outcome.valid?
      redirect_to root_path
    else
      flash[:alert] = ResourcesMessage.new(:create_post, outcome.errors).message
      redirect_to post_new_path
    end
  end
end
