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
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = CreateZipFiles.run(id: 1)
    Post.first.delete
    expect(interactor.valid?).to be true
  end
  it 'is zip stream not nil' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = CreateZipFiles.run(id: 1)
    Post.first.delete
    expect(interactor.zip_stream).not_to be nil
  end
  it 'is invalid without params' do
    allow(@config).to receive(:server_path) {@path}
    interactor = CreateZipFiles.run
    expect(interactor.valid?).to be nil
  end
  it 'is return error message without params' do
    allow(@config).to receive(:server_path) {@path}
    interactor = CreateZipFiles.run
    expect(interactor.errors.messages).to eq(id: ['is required'])
  end

  it 'is invalid with wrong params' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = CreateZipFiles.run(id: 54)
    Post.first.delete
    expect(interactor.valid?).to be false
  end
  it 'is zip stream is nil with wrong params' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = CreateZipFiles.run(id: 54)
    Post.first.delete
    expect(interactor.zip_stream).to be nil
  end
  it 'is return error messages with wrong params' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = CreateZipFiles.run(id: 54)
    Post.first.delete
    expect(interactor.errors.messages).to eq(post: ['does not exist'])
  end
end
