class PostController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create

  end
end
