# frozen_string_literal: true

require 'oauth2'

RSpec.describe CovaApi do
  let!(:oauth_client) { OAuth2::Client.new '', '' }
  let(:oauth_token) { OAuth2::AccessToken.from_hash(oauth_client, {}) }
  let(:oauth_password_strategy) { OAuth2::Strategy::Password.new(oauth_client) }
  let(:authentication) do
    {
      username: 'username',
      password: 'password',
      client_id: 'client_id',
      client_secret: 'client_secret'
    }
  end

  it 'has a base url' do
    expect(CovaApi::AUTH_URL).to eq('https://accounts.iqmetrix.net')
  end

  it 'has an auth endpoint' do
    expect(CovaApi::AUTH_ENDPOINT).to eq('/v1/oauth2/token')
  end

  describe '.authenticate' do
    before do
      allow(OAuth2::Client).to receive(:new) { oauth_client }
      allow(oauth_client).to receive(:password) { oauth_password_strategy }
      allow(oauth_password_strategy).to receive(:get_token) { oauth_token }
    end

    it 'sets the credentials instance variable' do
      CovaApi.authenticate(authentication)
      expect(CovaApi.instance_variable_get(:@credentials)).to eq(
        username: 'username',
        password: 'password',
        client_id: 'client_id',
        client_secret: 'client_secret'
      )
    end

    it 'sets the token instance variable' do
      CovaApi.authenticate(authentication)
      expect(CovaApi.instance_variable_get(:@token)).to eq(oauth_token)
    end

    it 'returns the token as a hash' do
      expect(CovaApi.authenticate(authentication)).to eq(
        access_token: '',
        expires_at: nil,
        refresh_token: nil
      )
    end
  end

  describe '.refresh' do
    describe 'when not authenticated' do
      it 'raises error' do
        expect { CovaApi.token }.to raise_error(CovaApi::MissingAuthentication)
      end
    end

    describe 'when authenticated' do
      before do
        CovaApi.instance_variable_set(:@token, oauth_token)
        CovaApi.instance_variable_set(
          :@credentials,
          username: 'username',
          password: 'password',
          client_id: 'client_id',
          client_secret: 'client_secret'
        )
      end

      describe 'when the token is expired' do
        before do
          allow(oauth_token).to receive(:expired?) { true }
        end

        it 'refreshes the token' do
          expect(oauth_token).to receive(:refresh!) { oauth_token }
          CovaApi.token
        end

        it 'sets a new token' do
          expect(CovaApi.instance_variable_get(:@token)).to eq(oauth_token)
          expect(oauth_token).to receive(:refresh!) { OAuth2::AccessToken.from_hash(oauth_client, {}) }
          CovaApi.token
          expect(CovaApi.instance_variable_get(:@token)).to_not eq(oauth_token)
        end
      end

      it 'returns the token as a hash' do
        expect(CovaApi.token).to eq(
          access_token: '',
          expires_at: nil,
          refresh_token: nil
        )
      end
    end
  end

  describe '.connection' do
    describe 'when authenticated' do
      before do
        @token_hash = CovaApi.authenticate(
          username: 'username',
          password: 'password',
          client_id: 'client_id',
          client_secret: 'client_secret',
          token_hash: {}
        )
      end

      it 'returns the oauth token connection' do
        connection = CovaApi.connection('https://www.example.com')
        expect(connection.class).to eq(OAuth2::AccessToken)
        expect(connection.to_hash).to eq(@token_hash)
      end
    end
  end
end
