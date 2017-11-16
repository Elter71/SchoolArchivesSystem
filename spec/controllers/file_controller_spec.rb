describe FileController do
  before(:all) do
    @config = Configuration.instance
    @path = "#{Rails.root}/spec/factories/ftp/"
    @factories_path = "#{Rails.root}/spec/factories/"
  end
  describe 'GET file/:id/:file_name' do
    it 'is return file' do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :get, params: {id: 1, file_name: 'file'}
      Post.first.delete
      expect(response.header['Content-Transfer-Encoding']).to eq('binary')
    end

    it 'is invalid no authentication user' do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
      FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :get, params: {id: 1, file_name: 'file'}
      Post.first.delete
      expect(response).to redirect_to new_user_session_path
    end

    it 'is return status 422 when wrong id' do
      sign_in FactoryBot.create(:user)

      get :get, params: {id: 56, file_name: 'file'}
      expect(response).to have_http_status(422)
    end

    it 'is return status 422 when wrong file name' do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :get, params: {id: 1, file_name: 'sad'}
      Post.first.delete
      expect(response).to have_http_status(422)
    end

    it 'is error message in body when wrong file name *JSON*' do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :get, params: {id: 1, file_name: 'sad'}, format: :json
      Post.first.delete
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['post_file']).to eq(['does not exist'])
    end

  end

  describe 'GET files/:id' do
    it 'is return files array' do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :get_all, params: {id: 1}
      Post.first.delete
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq(['file.txt'])
    end

    it 'is return status 422 when wrong id' do
      sign_in FactoryBot.create(:user)
      get :get_all, params: {id: 324}
      expect(response).to have_http_status(422)
    end

    it 'is return error message when wrong id' do
      sign_in FactoryBot.create(:user)
      get :get_all, params: {id: 324}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['post_file']).to eq(['does not exist'])
    end

    it 'not authenticate use' do
      get :get_all, params: {id: 23}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'files/:id/gallery' do

    it 'is return files array' do
      allow(@config).to receive(:server_path) {@path}
      img = Rack::Test::UploadedFile.new(@factories_path+'img.png', 'image/png')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [img]
      CreatePost.run(post)

      get :get_all_image, params: {id: 1}
      Post.first.delete
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq(['img.png'])
    end

    it "is return status 422 when can't found image" do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path+'file.txt', 'txt')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :get_all_image, params: {id: 1}
      Post.first.delete
      expect(response).to have_http_status(422)
    end


    it "is error message when can't found image" do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path+'file.txt', 'txt')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :get_all_image, params: {id: 1}
      Post.first.delete
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['post_file']).to eq(['does not exist'])
    end

    it 'is return status 422 when wrong id' do
      sign_in FactoryBot.create(:user)
      get :get_all_image, params: {id: 324}
      expect(response).to have_http_status(422)
    end

    it 'is return error message when wrong id' do
      sign_in FactoryBot.create(:user)
      get :get_all_image, params: {id: 324}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['post_file']).to eq(['does not exist'])
    end

    it 'not authenticate use' do
      get :get_all_image, params: {id: 23}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET files/:id/download' do
    it 'is return files zip' do
      allow(@config).to receive(:server_path) {@path}
      file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
      sign_in FactoryBot.create(:user)
      post = FactoryBot.build(:post).attributes
      post[:files] = [file]
      CreatePost.run(post)

      get :download_all_files, params: {id: 1}
      Post.first.delete
      expect(response.header['Content-Transfer-Encoding']).to eq('binary')
    end

    it 'is return status 422 when wrong id' do
      sign_in FactoryBot.create(:user)
      get :download_all_files, params: {id: 13}
      expect(response).to have_http_status(422)
    end

    it 'is return error message when wrong id *JSON*' do
      sign_in FactoryBot.create(:user)
      get :download_all_files, params: {id: 324}, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['post']).to eq(['does not exist'])
    end

    it 'not authenticate use' do
      get :download_all_files, params: {id: 23}
      expect(response).to redirect_to new_user_session_path
    end
  end

end
