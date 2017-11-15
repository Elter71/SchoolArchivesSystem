describe PostController do
  describe 'POST new' do
    before(:all) do
      @conf = Configuration.instance
      @path = "#{Rails.root}/spec/factories/ftp/"
    end

    it 'redirect_to root path' do
      sign_in FactoryBot.create(:user)
      allow(@conf).to receive(:server_path) {@path}

      post = FactoryBot.build(:post).attributes
      post 'create', params: {post: post}

      expect(response).to redirect_to root_path

      Post.first.destroy
    end

    it 'redirect to post new path' do
      sign_in FactoryBot.create(:user)
      allow(@conf).to receive(:server_path) {@path}
      post = FactoryBot.build(:post, title: nil).attributes
      post 'create', params: {post: post}

      expect(response).to redirect_to post_new_path
    end
    it 'flash[:alert] not nil' do
      sign_in FactoryBot.create(:user)
      allow(@conf).to receive(:server_path) {@path}

      post = FactoryBot.build(:post, title: nil).attributes
      post 'create', params: {post: post}

      expect(flash[:alert]).to_not be nil
    end

    it 'is saving file' do
      @file = Rack::Test::UploadedFile.new("#{Rails.root}//spec/factories/file.txt",'text')
      @img = Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/img.png", 'image/png')

      sign_in FactoryBot.create(:user)
      allow(@conf).to receive(:server_path) {@path}
      post = FactoryBot.build(:post, user: User.first).attributes
      post[:files] = [@img,@file]
      post 'create', params: {post: post}

      expect(File.exist?("#{@path}#{Post.first.id}/file.txt")).to be true
      expect(File.exist?("#{@path}#{Post.first.id}/img.png")).to be true

      Post.first.destroy
    end

    it 'not authenticate use' do
      post 'create'
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET new' do
    it 'assigns @post' do
      sign_in FactoryBot.create(:user)
      get :new
      expect(assigns(:post)).not_to be nil
    end

    it 'renders the new template' do
      sign_in FactoryBot.create(:user)
      get :new
      expect(response).to render_template('new')
    end

    it 'not authenticate use' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET post/:id' do
    it 'html renders the get template' do
      sign_in FactoryBot.create(:user)
      post = FactoryBot.create(:post)

      get :get, params: {id: post.id}

      expect(response).to render_template('get')
    end

    it 'json render @post object' do
      sign_in FactoryBot.create(:user)
      post = FactoryBot.create(:post)

      get :get, params: {id: post.id}, format: :json
      expect(response.body).to eq(post.to_json)
    end

    it 'html with incorrect param returns a 422 status' do
      sign_in FactoryBot.create(:user)
      get :get, params: {id: 23}

      expect(response).to have_http_status(422)
    end

    it 'html with incorrect param returns empty body' do
      sign_in FactoryBot.create(:user)
      get :get, params: {id: 23}

      expect(response.body).to be_empty
    end

    it 'json with incorrect param returns a 422 status' do
      sign_in FactoryBot.create(:user)
      get :get, params: {id: 23}, format: :json

      expect(response).to have_http_status(422)
    end

    it 'json with incorrect param returns error messages' do
      sign_in FactoryBot.create(:user)
      get :get, params: {id: 23}, format: :json

      expect(response.body).not_to be nil
    end

    it 'not authenticate use' do
      get :get, params: {id: 23}
      expect(response).to redirect_to new_user_session_path
    end
  end
end
