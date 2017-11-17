require 'active_interaction'

class UpdateUser < ActiveInteraction::Base
  integer :id, :role_id, default: nil
  string :password, :email, :first_name, :last_name, default: nil
  boolean :active, default: nil
  object :user
  validates :user, :id, presence: true

  def execute
    if_user_by_id_exist
  end

  private

  def if_user_by_id_exist
    @user_by_id = User.find_by_id(@id)
    if @user_by_id
      check_authorisation
    else
      add_id_error
    end
    @user_by_id
  end

  def check_authorisation
    params = delete_nil_from_input
    if @user.ability.can? :change_password, @user_by_id
      check_type_of_update(params)
    else
      add_authorisation_error
    end
  end

  def check_type_of_update(params)
    if @user.ability.can? :manage, User
      @user_by_id.update(params)
    else
      @user_by_id.update(only_password_params(params))
    end
  end

  def delete_nil_from_input
    params = inputs
    params.delete(:user)
    params.each_with_index do |key, value|
      params.delete(key) unless value
    end
    params
  end

  def only_password_params(params)
    result = {}
    if params['password']
      result = {id: params['id'], password: params['password']}
    end
    result
  end

  def add_id_error
    errors.add(:id, 'user does exist')
  end

  def add_authorisation_error
    errors.add(:user, 'wrong authorisation')
  end
end
