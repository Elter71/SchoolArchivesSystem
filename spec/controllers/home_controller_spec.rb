describe HomeController do
  login_user
  describe 'GET index' do
    it 'assigns @post' do
      get :index
      post = FactoryBot.create(:post, user: User.first)
      expect(assigns(:post)).to eq([post])
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end