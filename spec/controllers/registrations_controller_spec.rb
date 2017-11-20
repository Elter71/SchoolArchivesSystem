describe RegistrationsController do
  describe 'PUT update' do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end
    it 'update data *password by user*' do
      user = FactoryBot.create(:user)
      sign_in user
      put :update, params: {id: user.id, password: 'newPasssword'}
      response_json = JSON.parse(response.body)
      expect(response_json['password']).not_to eq(user.password)
    end

    it 'render status 422 with wrong params' do
      sign_in FactoryBot.create(:user)

      put :update, params: {}
      expect(response).to have_http_status(422)
    end

    it 'render errors message with wrong params' do
      sign_in FactoryBot.create(:user)
      put :update, params: {id: 123}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(['user does exist'])
    end

    it 'not authenticate use' do
      put :update
      expect(response).to redirect_to new_user_session_path
    end
  end
end
