require 'rails_helper'
describe 'CreateZipFile interaction' do
  it 'is valid' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'img')
    
    expect(interactor.valid?).to be true
  end
  it 'is return file' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'img')
    
    expect(interactor.file.path).to eq("#{@path}1/img.png")
  end
  it 'is invalid without id' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(file_name: 'img')

    

    expect(interactor.valid?).to be nil
  end
  it 'is invalid without file name' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 2)

    

    expect(interactor.valid?).to be nil
  end

  it 'is invalid with wrong id' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 2, file_name: 'img')

    

    expect(interactor.valid?).to be false
  end

  it 'is invalid with wrong file name' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'sdfgg')

    

    expect(interactor.valid?).to be false
  end

  it 'is return file is nil when invalid' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'sdfgg')

    

    expect(interactor.file).to be nil
  end
  it 'is return errors message when invalid' do
    
    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    FactoryBot.create(:user)
    post = FactoryBot.build(:post).attributes
    post[:files] = [img]
    CreatePost.run(post)

    interactor = FindFile.run(id: 1, file_name: 'sdfgg')

    

    expect(interactor.errors.messages).to eq(post_file: ['does not exist'])
  end
end
