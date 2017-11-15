require 'rails_helper'
describe 'CreatePost interaction' do

  before(:all) do
    @config = Configuration.instance
    @path = "#{Rails.root}/spec/factories/ftp/"
    @factories_path = "#{Rails.root}/spec/factories/"
  end

  it 'is valid' do
    allow(@config).to receive(:server_path) {@path}
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    interactor = CreatePost.run(post)

    expect(interactor.valid?).to be true

    interactor.result.delete
  end

  it 'return post on valid' do
    allow(@config).to receive(:server_path) {@path}
    FactoryBot.create(:user)
    post = FactoryBot.build(:post)
    interactor = CreatePost.run(post.attributes)

    expect(interactor.result.title).to eq(post.title)
    expect(interactor.result.description).to eq(post.description)
    expect(interactor.result.tag).to eq(post.tag)

    interactor.result.delete
  end
  it 'is create folder' do
    allow(@config).to receive(:server_path) {@path}
    FactoryBot.create(:user)
    post = FactoryBot.build(:post)
    interactor = CreatePost.run(post.attributes)

    is_created = Dir.exist?(@path+"/#{post.id}/")
    expect(is_created).to be true
    interactor.result.delete
  end

  it 'is invalid without title' do
    FactoryBot.create(:user)
    post = FactoryBot.build(:post, title: nil)
    interactor = CreatePost.run(post.attributes)
    expect(interactor.valid?).to be nil
  end

  it 'is invalid without user_id' do
    FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: nil)
    interactor = CreatePost.run(post.attributes)
    expect(interactor.valid?).to be nil
  end

  it 'is invalid without description' do
    FactoryBot.create(:user)
    post = FactoryBot.build(:post, description: nil)
    interactor = CreatePost.run(post.attributes)
    expect(interactor.valid?).to be nil
  end
  it 'is return error messages without user_id' do
    FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: nil)
    interactor = CreatePost.run(post.attributes)

    expect(interactor.errors.messages).to eq(user_id: ['is required'])
  end
  it 'is return error messages without title' do
    FactoryBot.create(:user)
    post = FactoryBot.build(:post, title: nil)
    interactor = CreatePost.run(post.attributes)

    expect(interactor.errors.messages).to eq(title: ['is required'])
  end

  it 'is return error messages without description' do
    FactoryBot.create(:user)
    post = FactoryBot.build(:post, description: nil)
    interactor = CreatePost.run(post.attributes)

    expect(interactor.errors.messages).to eq(description: ['is required'])
  end

  it 'add thumbnail to post when can find image' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path+'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    interactor = CreatePost.run(post)

    expect(interactor.result.thumbnail).to eq('img.png')

    interactor.result.delete
  end

  it "empty thumbnail to post when can't find image" do
    allow(@config).to receive(:server_path) {@path}
    file = Rack::Test::UploadedFile.new(@factories_path+'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [file]
    interactor = CreatePost.run(post)

    expect(interactor.result.thumbnail).to eq('')

    interactor.result.delete
  end

  it 'save file' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path+'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    interactor = CreatePost.run(post)

    expect(File.exist?(@factories_path+'img.png')).to be true

    interactor.result.delete
  end
  it 'save files' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path+'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path+'file.txt', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    interactor = CreatePost.run(post)

    expect(File.exist?(@factories_path+'img.png')).to be true
    expect(File.exist?(@factories_path+'file.txt')).to be true

    interactor.result.delete
  end

end