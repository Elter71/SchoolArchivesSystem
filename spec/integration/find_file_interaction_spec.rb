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

    interactor = FindFile.run(id: 1, file_name: 'img')
    Post.first.delete
    expect(interactor.valid?).to be true
  end
  it 'is return file' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'img')
    Post.first.delete
    expect(interactor.file.path).to eq("#{@path}1/img.png")
  end
  it 'is invalid without id' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(file_name: 'img')

    Post.first.delete

    expect(interactor.valid?).to be nil
  end
  it 'is invalid without file name' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 2)

    Post.first.delete

    expect(interactor.valid?).to be nil
  end

  it 'is invalid with wrong id' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 2, file_name: 'img')

    Post.first.delete

    expect(interactor.valid?).to be false
  end

  it 'is invalid with wrong file name' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'sdfgg')

    Post.first.delete

    expect(interactor.valid?).to be false
  end

  it 'is return file is nil when invalid' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'sdfgg')

    Post.first.delete

    expect(interactor.file).to be nil
  end
  it 'is return errors message when invalid' do
    allow(@config).to receive(:server_path) {@path}
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'sdfgg')

    Post.first.delete

    expect(interactor.errors.messages).to eq(post_file: ['does not exist'])
  end
end
