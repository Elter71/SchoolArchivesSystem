class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.all
    @post.each do |id|
      id.thumbnail
    end
  end
end
