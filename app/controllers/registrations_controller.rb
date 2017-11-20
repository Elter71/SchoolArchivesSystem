class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy, :new, :create]


  def update
    outcome = UpdateUser.run(params.merge(user: current_user))
    if outcome.valid?
      render json: outcome.result
    else
      render json: outcome.errors.messages, status: 422
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params_role
    params.require(:user).permit(:email, :role_id, :active)
  end

  def sign_up(resource_name, resource)
    nil
  end

end
