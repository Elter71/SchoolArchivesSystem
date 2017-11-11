class UserController < ApplicationController
  before_action :authenticate_user!
  before_action AdminFilter, except: :get


  def roles
    render json: Role.all
  end

  def users
    render json: User.all
  end

  def get
    outcome = FindUser.run(params.merge(user: current_user))
    if outcome.valid?
      render json: outcome.result
    else
      render json: outcome.errors.messages, status: 422
    end
  end

end
