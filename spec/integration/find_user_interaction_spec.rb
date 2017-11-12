require 'rails_helper'

describe 'FindUser Interaction' do
  it 'return full of user data when ask user' do
    user = FactoryBot.create(:user)
    out_value = FindUser.run(id: user.id, user: user)

    expect(out_value.valid?).to be true
    expect(out_value.result).to eq(user)
  end

  it 'return full of user data when ask admin' do
    user = FactoryBot.create(:user)
    user_admin = FactoryBot.create(:user, :admin, email: 'some@w.pl')
    out_value = FindUser.run(id: user.id, user: user_admin)

    expect(out_value.valid?).to be true
    expect(out_value.result).to eq(user)
  end
  it 'return only first name and last name ' do
    user = FactoryBot.create(:user)
    user_two = FactoryBot.create(:user, email: 'some@w.pl')
    out_value = FindUser.run(id: user_two.id, user: user)

    expect(out_value.valid?).to be true
    expect(out_value.result).to eq(first_name: user_two.first_name, last_name: user_two.last_name)
  end
  it "can't find user" do
    user = FactoryBot.create(:user)
    out_value = FindUser.run(id: 2, user: user)

    expect(out_value.valid?).to be false
    expect(out_value.errors.messages).to eq(id: ['does not exist'])
  end
end
