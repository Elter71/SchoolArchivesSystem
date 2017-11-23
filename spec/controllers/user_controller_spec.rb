require 'spec_helper'
describe UserController do

  describe 'GET roles' do

    it 'when admin' do
      sign_in FactoryBot.create(:user, :admin)
      get :roles
      expect(response).to be_success
    end

    it 'when user' do
      sign_in FactoryBot.create(:user)
      get :roles
      expect(response).to redirect_to root_path
    end

    it 'when not authenticate use' do
      get :roles
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET users' do
    it 'when admin *json*' do
      sign_in FactoryBot.create(:user, :admin)
      get :users, format: 'json'
      expect(response).to be_success
    end
    it 'when admin *html' do
      sign_in FactoryBot.create(:user, :admin)
      get :users
      expect(response).to redirect_to root_path
    end

    it 'when user' do
      sign_in FactoryBot.create(:user)
      get :users
      expect(response).to redirect_to root_path
    end

    it 'when not authenticate use' do
      get :users
      expect(response).to redirect_to new_user_session_path
    end

  end

  describe 'GET user/:id' do
    login_user

    it 'when id = asking user id' do
      get :get, params: {id: User.find_by_email('some@example.com').id}
      expect(response.body).to eq(User.find_by_email('some@example.com').to_json)
    end

    it 'when id is empty' do
      get :get, params: {id: ''}
      expect(response).to have_http_status(422)
    end

    it 'when user from id not exist' do
      get :get, params: {id: 55}
      expect(response).to have_http_status(422)
    end

    it 'when id is not asking user id' do
      user = FactoryBot.create(:user, email: 'new@mail.com')
      get :get, params: {id: 2}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['first_name']).to eq(user.first_name)
      expect(parsed_response['last_name']).to eq(user.last_name)
    end

  end

end
