class PostController < ApplicationController
  before_action :authenticate_user!

  def new
    flash.clear
    @post = Post.new
  end

  def get
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.save_files(params[:post][:files])
    else
      message = ResourcesMessage.new(@post, @post.errors).message
      flash[:alert] = message
      render post_new_path
      return
    end
    flash[:notice] = "Succes!!"
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :tag).merge(user_id: current_user.id)
  end
end
