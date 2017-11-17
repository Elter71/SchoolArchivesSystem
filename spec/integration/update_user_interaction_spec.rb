require 'rails_helper'
describe 'UpdateUser interaction' do
  it 'is valid when admin update user' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: admin)
    expect(interaction.valid?).to be true
    expect(interaction.result).to eq(update_user)
  end

  it 'is invalid when user update admin' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: admin.id, user: update_user)
    expect(interaction.valid?).to be false
  end

  it 'is valid when user update yours-self' do
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: update_user)
    expect(interaction.valid?).to be true
  end

  it 'is invalid when user update user ' do
    user = FactoryBot.create(:user)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: user)
    expect(interaction.valid?).to be false
  end

  it 'is invalid without params' do
    interaction = UpdateUser.run
    expect(interaction.valid?).to be nil
  end

  it 'is error messages without params' do
    interaction = UpdateUser.run
    expect(interaction.errors.messages).to eq(user: ['is required'])
  end

  it 'is invalid without id' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(user: admin)
    expect(interaction.valid?).to be false
  end

  it 'is error messages without id' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(user: admin)
    expect(interaction.errors.messages).to eq(id: ["can't be blank"])
  end

  it 'is invalid without user' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id)
    expect(interaction.valid?).to be nil
  end
  it 'is error messages without user' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: admin.id)
    expect(interaction.errors.messages).to eq(user: ['is required'])
  end

  it 'is invalid with wrong id' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: 123, user: admin)
    expect(interaction.valid?).to be false
  end
  it 'is error message with wrong id' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: 123, user: admin)
    expect(interaction.errors.messages).to eq(id: ['user does exist'])
  end
  it 'is invalid with wrong user' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: 'lalala')
    expect(interaction.valid?).to be nil
  end
  it 'is invalid with wrong user' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: 'lalala')
    expect(interaction.errors.messages).to eq(user: ['is not a valid object'])
  end

  it 'is update role *by admin*' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: admin, role_id: 2)
    expect(interaction.valid?).to be true
    expect(interaction.result.role_id).to eq(2)
  end

  it 'is update active *by admin*' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: admin, active: false)
    expect(interaction.valid?).to be true
    expect(interaction.result.active).to eq(false)
  end

  it 'is update password *by admin*' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')
    old_password = update_user.password

    interaction = UpdateUser.run(id: update_user.id, user: admin, password: 'newpassword')
    expect(interaction.valid?).to be true
    expect(interaction.result.password).not_to eq(old_password)
  end

  it 'is update last name *by admin*' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: admin, last_name: 'NAME')
    expect(interaction.valid?).to be true
    expect(interaction.result.last_name).to eq('NAME')
  end

  it 'is update first name *by admin*' do
    admin = FactoryBot.create(:user, :admin)
    update_user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: update_user.id, user: admin, first_name: 'NAME')
    expect(interaction.valid?).to be true
    expect(interaction.result.first_name).to eq('NAME')
  end

  it 'is update password *by user*' do
    user = FactoryBot.create(:user, email: 'new@mail.com')
    old_password = user.password

    interaction = UpdateUser.run(id: user.id, user: user, password: 'newpassword')
    expect(interaction.valid?).to be true
    expect(interaction.result.password).not_to eq(old_password)
  end

  it 'is update role *by user*' do
    user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: user.id, user: user, role_id: 2)
    expect(interaction.result.role_id).to eq(1)
  end

  it 'is update active *by user*' do
    user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: user.id, user: user, active: false)
    expect(interaction.result.active).to eq(true)
  end

  it 'is update last name *by user*' do
    admin = FactoryBot.create(:user, :admin)
    user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: user.id, user: user, last_name: 'NAME')

    expect(interaction.result.last_name).to eq(user.last_name)
  end

  it 'is update first name *by user*' do
    user = FactoryBot.create(:user, email: 'new@mail.com')

    interaction = UpdateUser.run(id: user.id, user: user, first_name: 'NAME')
    expect(interaction.result.first_name).to eq(user.first_name)
  end
end
