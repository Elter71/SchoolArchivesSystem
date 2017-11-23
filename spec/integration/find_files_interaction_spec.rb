require 'rails_helper'
describe 'FindFiles interaction' do
  it 'is valid' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 1)
    
    expect(interactor.valid?).to be true
  end

  it 'is return files name array' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 1)
    
    expect(interactor.files_name).to eq(['img.png', 'file.txt'])
  end

  it 'is invalid without id' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run()
    
    expect(interactor.valid?).to be nil
  end

  it 'is invalid with wrong id' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 23)
    
    expect(interactor.valid?).to be false
  end

  it 'is return empty array when invalid' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    file = Rack::Test::UploadedFile.new(@factories_path + 'file.txt', 'txt')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img, file]
    CreatePost.run(post)

    interactor = FindFiles.run(id: 23)
    
    expect(interactor.files_name).to eq []
  end

end
