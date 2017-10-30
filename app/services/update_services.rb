class UpdateServices
  def initialize(controller)
    @controller = controller
  end

  def change_role(params)
    if update_user(params)
      @controller.render json: @user, status: :ok
    else
      @controller.render json: nil, status: :not_acceptable
    end
  end

  private def update_user(params)
    @user = User.find_by_email(params[:email])
    @user.role = Role.find(params[:role_id])
    @user.save
  end

  def update_with_password(resource, params)
    if resource.update_with_password(params)
      @controller.render json: resource, status: :ok
    else
      @controller.render json: resource, status: :not_acceptable
    end
  end
end