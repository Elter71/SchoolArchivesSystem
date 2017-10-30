class UserController < ApplicationController
  before_action :authenticate_user!, AdminFilter


  def settings
  end

  def roles
    render json: Role.all
  end

  def users
    render json: User.all
  end

end
