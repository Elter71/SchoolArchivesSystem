describe 'Role' do

  it 'is valid' do
    expect(FactoryBot.build(:role).save).to be true
  end
  it 'is invalid without name' do
    expect(FactoryBot.build(:role, name: nil).save).to be false
  end
  it 'is hash to many user' do
    role = FactoryBot.create(:role)
    user = FactoryBot.create(:user, role: role)
    expect(role.users.first).to eq(user)
  end
end