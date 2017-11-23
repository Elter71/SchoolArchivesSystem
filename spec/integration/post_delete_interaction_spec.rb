require 'rails_helper'
describe 'DeletePost interaction' do

  it 'is valid' do

    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    post = CreatePost.run(post).result

    interactor = DeletePost.run(id: post.id, user: user)

    expect(interactor.valid?).to be true
  end

  it 'delete file' do

    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    post[:files] = [img]
    post = CreatePost.run(post).result

    interactor = DeletePost.run(id: post.id, user: user)

    expect(interactor.valid?).to be true
    expect(File.exist?(@path + "#{post.id}/img.png")).to be false
  end

  it 'delete post' do

    img = Rack::Test::UploadedFile.new(@factories_path + 'img.png', 'image/png')
    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    post[:files] = [img]
    post = CreatePost.run(post).result

    interactor = DeletePost.run(id: post.id, user: user)

    expect(interactor.valid?).to be true
    expect(Post.all.size).to eq(0)
  end

  it 'invalid without params' do

    interaction = DeletePost.run
    expect(interaction.valid?).to be nil
  end

  it 'invalid without id' do

    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    CreatePost.run(post)

    interactor = DeletePost.run(user: user)

    expect(interactor.valid?).to be nil
  end

  it 'invalid without user' do
    FileUtils.rm_rf(@path + '1/')

    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    post = CreatePost.run(post).result

    interactor = DeletePost.run(id: post.id)

    expect(interactor.valid?).to be nil
  end

  it 'invalid with wrong authorization' do
    FileUtils.rm_rf(@path + '1/')

    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: User.first.id).attributes
    post = CreatePost.run(post).result

    interactor = DeletePost.run(id: post.id, user: user)

    expect(interactor.valid?).to be false

  end

  it 'no authorization error message' do
    FileUtils.rm_rf(@path + '1/')

    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: User.first.id).attributes
    post = CreatePost.run(post).result

    interactor = DeletePost.run(id: post.id, user: user)

    expect(interactor.errors.messages).to eq(user: ['wrong authorization'])
  end

  it 'wrong post id error message' do
    FileUtils.rm_rf(@path + '1/')

    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    CreatePost.run(post)

    interactor = DeletePost.run(id: 2135, user: user)

    expect(interactor.errors.messages).to eq(post: ['does not exist'])
  end

  it 'error message without id' do
    FileUtils.rm_rf(@path + '1/')


    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    post = CreatePost.run(post).result

    interactor = DeletePost.run(user: user)

    expect(interactor.errors.messages).to eq(id: ['is required'])

  end
  it 'error message without user' do

    user = FactoryBot.create(:user)
    post = FactoryBot.build(:post, user_id: user.id).attributes
    post = CreatePost.run(post).result

    interactor = DeletePost.run(id: post.id)

    expect(interactor.errors.messages).to eq(user: ['is required'])

  end
end
