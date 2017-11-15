require 'rails_helper'
describe 'FindPost interaction' do
  it 'is valid' do
    FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    interactor = FindPost.run(id: post.id)
    expect(interactor.valid?).to be true
  end

  it 'is return post on valid ' do
    FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    interactor = FindPost.run(id: post.id)
    expect(interactor.result).to eq(post)
  end

  it 'is invalid without id' do
    interactor = FindPost.run()
    expect(interactor.valid?).to be nil
  end
  it 'is invalid with wrong id' do
    FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    interactor = FindPost.run(id: 22)
    expect(interactor.valid?).to be false
  end
  it 'is add error message on invalid without id' do
    interactor = FindPost.run()
    expect(interactor.errors.messages).to eq(id: ['is required'])
  end

  it 'is add error message on invalid with wrong id' do
    FactoryBot.create(:user)
    post = FactoryBot.create(:post)

    interactor = FindPost.run(id: 22)
    expect(interactor.errors.messages).to eq(id: ['does not exist'])
  end
end