describe HomeController do
  describe 'GET index' do
    it 'assigns @post' do
      sign_in FactoryBot.create(:user)
      get :index
      post = FactoryBot.create(:post, user: User.first)
      expect(assigns(:post)).to eq([post])
    end
    it 'renders the index template' do
      sign_in FactoryBot.create(:user)
      get :index
      expect(response).to render_template('index')
    end
    it 'not authenticate use' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end