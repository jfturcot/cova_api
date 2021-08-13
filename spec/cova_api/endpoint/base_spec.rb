# frozen_string_literal: true

require 'oauth2'

class TestConnection
  extend CovaApi::Endpoint::Base

  def self.url
    'https://test.iqmetrix.com'
  end

  def self.prefix
    '/test/v1'
  end
end

RSpec.describe CovaApi::Endpoint::Base do
  let(:connection) { CovaApi.connection(CovaApi::Endpoint::Base.url) }

  it 'has a base url' do
    expect(CovaApi::Endpoint::Base.url).to eq('https://api.covasoft.net')
  end

  it 'has a base prefix' do
    expect(CovaApi::Endpoint::Base.prefix).to eq('/v1')
  end

  describe 'http methods' do
    before do
      CovaApi.authenticate(
        username: 'username',
        password: 'password',
        client_id: 'client_id',
        client_secret: 'client_secret',
        token_hash: {}
      )
    end

    it 'sets up the connection' do
      allow(connection).to receive(:get)
      expect(CovaApi).to receive(:connection).with('https://test.iqmetrix.com') { connection }
      TestConnection.get('/examples', params: { 'test': '123' })
    end

    it 'prepends the prefix to the path' do
      expect(connection).to receive(:get).with('/test/v1/examples', params: { test: '123' })
      expect(CovaApi).to receive(:connection).with('https://test.iqmetrix.com') { connection }
      TestConnection.get('/examples', params: { 'test': '123' })
    end

    describe '.get' do
      it 'sends a get request via connection' do
        allow(TestConnection).to receive(:connection) { connection }
        expect(connection).to receive(:get).with('/test/v1/examples', params: { test: '123' })
        TestConnection.get('/examples', params: { 'test': '123' })
      end
    end

    describe '.post' do
      it 'sends a post request via connection' do
        allow(TestConnection).to receive(:connection) { connection }
        expect(connection).to receive(:post).with('/test/v1/examples', params: { test: '123' }, body: { data: '321' })
        TestConnection.post('/examples', params: { 'test': '123' }, body: { 'data': '321' })
      end
    end

    describe '.put' do
      it 'sends a put request via connection' do
        allow(TestConnection).to receive(:connection) { connection }
        expect(connection).to receive(:put).with('/test/v1/examples', params: { test: '123' }, body: { data: '321' })
        TestConnection.put('/examples', params: { 'test': '123' }, body: { 'data': '321' })
      end
    end

    describe '.delete' do
      it 'sends a delete request via connection' do
        allow(TestConnection).to receive(:connection) { connection }
        expect(connection).to receive(:delete).with('/test/v1/examples', {})
        TestConnection.delete('/examples')
      end
    end
  end
end
