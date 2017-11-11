describe 'Ability' do

  it 'is user can create post' do
    user = FactoryBot.create(:user)
    ability = Ability.new(user)
    expect(ability.can? :create, Post).to be true
  end
  it 'is user can manage yourself' do
    user = FactoryBot.create(:user)
    ability = Ability.new(user)
    expect(ability.can? :manage, user).to be false
  end
  it 'is user can change_password yourself' do
    user = FactoryBot.create(:user)
    ability = Ability.new(user)
    expect(ability.can? :change_password, user).to be true
  end
  it 'is user can see yours details' do
    user = FactoryBot.create(:user)
    ability = Ability.new(user)
    expect(ability.can? :see_details, user).to be true
  end
  it 'is user can delete yours post' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:post, user_id: user.id)
    ability = Ability.new(user)
    expect(ability.can? :delete, user.posts.first).to be true
  end
  it 'is admin can create post' do
    user = FactoryBot.create(:user, role_id: 2)
    ability = Ability.new(user)
    expect(ability.can? :create, Post).to be true
  end
  it 'is admin can manage all users' do
    user = FactoryBot.create(:user, role_id: 2)
    ability = Ability.new(user)
    expect(ability.can? :manage, User).to be true
  end
  it 'is admin can delete all posts' do
    user = FactoryBot.create(:user, role_id: 2)
    ability = Ability.new(user)
    expect(ability.can? :delete, Post).to be true
  end
end