module ControllerHelpers

  def login_admin
    before(:each) do
      user = FactoryBot.create(:user, :admin)
      @current_user = user
      sign_in user
    end
  end


  def login_user
    before(:each) do
      user = FactoryBot.create(:user)
      @current_user = user
      sign_in user
    end
  end


end