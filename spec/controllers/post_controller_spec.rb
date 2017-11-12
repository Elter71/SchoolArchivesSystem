describe PostController do
  login_user

  describe 'POST new' do
    before(:all) do
      @conf = Configuration.instance
      @path = "#{Rails.root}/spec/factories/ftp/"
    end

    it 'redirect_to root path' do
      allow(@conf).to receive(:server_path) {@path}

      post = FactoryBot.build(:post, user: User.first).attributes
      post 'create', params: {post: post}

      expect(response).to redirect_to root_path

      Post.first.destroy
    end

    it 'redirect to post new path' do
      allow(@conf).to receive(:server_path) {@path}

      post = FactoryBot.build(:post, user: User.first, title: nil).attributes
      post 'create', params: {post: post}

      expect(response).to redirect_to post_new_path
    end
    it 'flash[:alert] not nil' do
      allow(@conf).to receive(:server_path) {@path}

      post = FactoryBot.build(:post, user: User.first, title: nil).attributes
      post 'create', params: {post: post}

      expect(flash[:alert]).to_not be nil
    end
  end

  describe 'GET new' do
    it 'assigns @post' do
      get :new
      expect(assigns(:post)).not_to be nil
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET post/:id' do

    it 'html renders the get template' do
      post = FactoryBot.create(:post, user: User.first)

      get :get, params: {id: post.id}

      expect(response).to render_template('get')
    end

    it 'json render @post object' do
      post = FactoryBot.create(:post, user: User.first)

      get :get, params: {id: post.id}, format: :json
      expect(response.body).to eq(post.to_json)
    end


    it 'html with incorrect param returns a 422 status' do
      get :get, params: {id: 23}

      expect(response).to have_http_status(422)
    end

    it 'html with incorrect param returns empty body' do
      get :get, params: {id: 23}

      expect(response.body).to be_empty
    end

    it 'json with incorrect param returns a 422 status' do
      get :get, params: {id: 23}, format: :json

      expect(response).to have_http_status(422)
    end
    it 'json with incorrect param returns error messages' do
      get :get, params: {id: 23}, format: :json

      expect(response.body).not_to be nil
    end
  end
end