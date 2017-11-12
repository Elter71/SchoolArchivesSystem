describe 'Post' do

  it 'is valid' do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:post, user: user).save).to be true
  end

  it 'is invalid without user' do
    expect(FactoryBot.build(:post).save).to be false
  end
  it 'is invalid without title' do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:post, title: nil, user: user).save).to be false
  end
  it 'is invalid without description' do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:post, description: nil, user: user).save).to be false
  end
  it 'is valid without tag' do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:post, tag: nil, user: user).save).to be true
  end
  it 'is valid without thumbnail' do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:post, thumbnail: nil, user: user).save).to be true
  end
end