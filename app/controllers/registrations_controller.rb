class RegistrationsController < Devise::RegistrationsController


  def update
    update_services = UpdateServices.new(self)
    if current_user.ability.can? :change, Role
      update_services.change_role(account_update_params_role)
    else
      update_services.update_with_password(resource, account_update_params)
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params_role
    params.require(:user).permit(:email, :role_id)
  end

end
