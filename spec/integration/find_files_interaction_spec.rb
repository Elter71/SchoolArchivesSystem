require 'rails_helper'
describe 'CreateZipFile interaction' do
  before(:all) do
    @config = Configuration.instance
    @path = "#{Rails.root}/spec/factories/ftp/"
    @factories_path = "#{Rails.root}/spec/factories/"
  end
  it 'is valid' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 1)
    Post.first.delete
    expect(interactor.valid?).to be true
  end

  it 'is return files name array' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 1)
    Post.first.delete
    expect(interactor.files_name).to eq(['file.txt', 'img.png'])
  end

  it 'is invalid without id' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run()
    Post.first.delete
    expect(interactor.valid?).to be nil
  end

  it 'is invalid with wrong id' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 23)
    Post.first.delete
    expect(interactor.valid?).to be false
  end

  it 'is return empty array when invalid' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 23)
    Post.first.delete
    expect(interactor.files_name).to eq []
  end

end
