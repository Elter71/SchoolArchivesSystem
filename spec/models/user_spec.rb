
describe 'User' do

  it 'is valid' do
    user = FactoryBot.build(:user)

    expect(user.save).to be true
  end

  it 'is invalid without email' do
    user = FactoryBot.build(:user, email: nil)

    expect(user.save).to be false
  end

  it 'is invalid without unique email' do
    FactoryBot.create(:user)
    user = FactoryBot.build(:user, email: 'some@example.com')

    expect(user.save).to be false
  end

  it 'is invalid without first name' do
    user = FactoryBot.build(:user, first_name: nil)
    expect(user.save).to be false
  end

  it 'is invalid without last name' do
    user = FactoryBot.build(:user, last_name: nil)
    expect(user.save).to be false
  end

  it 'is invalid without password' do
    user = FactoryBot.build(:user, password: nil)

    expect(user.save).to be false
  end

  it 'is role will be user' do
    user = FactoryBot.create(:user)
    expect(user.role).to eq(Role.find_by_name('user'))
  end
  it 'is user will be active' do
    user = FactoryBot.create(:user)
    expect(user.active).to be true
  end

end