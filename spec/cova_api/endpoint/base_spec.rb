# frozen_string_literal: true

require 'oauth2'

class TestConnection
  extend CovaApi::Endpoint::Base
end

class TestUrlConnection
  extend CovaApi::Endpoint::Base

  def self.url
    'https://test.iqmetrix.com'
  end
end

class TestPrefixConnection
  extend CovaApi::Endpoint::Base

  def self.prefix
    '/test/v1'
  end
end

class TestUrlPrefixConnection
  extend CovaApi::Endpoint::Base

  def self.url
    'https://test.iqmetrix.com'
  end

  def self.prefix
    '/test/v1'
  end
end

RSpec.describe CovaApi::Endpoint::Base do
  let(:connection) { CovaApi.connection('https://api.covasoft.net') }

  it 'has a base url' do
    expect(TestConnection.url).to eq('https://api.covasoft.net')
  end

  it 'has a base prefix' do
    expect(TestConnection.prefix).to eq('/v1')
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

    describe 'when the url and the prefix are set on the class' do
      it 'sets up the url and prepends the prefix to the path' do
        expect(connection).to receive(:get).with('/test/v1/examples', params: { test: '123' })
        expect(CovaApi).to receive(:connection).with('https://test.iqmetrix.com') { connection }
        TestUrlPrefixConnection.get('/examples', params: { 'test': '123' })
      end

      describe '.get' do
        it 'sends a get request via connection' do
          allow(TestUrlPrefixConnection).to receive(:connection) { connection }
          expect(connection).to receive(:get).with('/test/v1/examples', params: { test: '123' })
          TestUrlPrefixConnection.get('/examples', params: { 'test': '123' })
        end
      end

      describe '.post' do
        it 'sends a post request via connection' do
          allow(TestUrlPrefixConnection).to receive(:connection) { connection }
          expect(connection).to receive(:post).with('/test/v1/examples', params: { test: '123' }, body: { data: '321' })
          TestUrlPrefixConnection.post('/examples', params: { 'test': '123' }, body: { 'data': '321' })
        end
      end

      describe '.put' do
        it 'sends a put request via connection' do
          allow(TestUrlPrefixConnection).to receive(:connection) { connection }
          expect(connection).to receive(:put).with('/test/v1/examples', params: { test: '123' }, body: { data: '321' })
          TestUrlPrefixConnection.put('/examples', params: { 'test': '123' }, body: { 'data': '321' })
        end
      end

      describe '.delete' do
        it 'sends a delete request via connection' do
          allow(TestUrlPrefixConnection).to receive(:connection) { connection }
          expect(connection).to receive(:delete).with('/test/v1/examples', {})
          TestUrlPrefixConnection.delete('/examples')
        end
      end
    end

    describe 'when only the url is set on the class' do
      it 'sets up the url and prepends the prefix to the path' do
        expect(connection).to receive(:get).with('/v1/examples', params: { test: '123' })
        expect(CovaApi).to receive(:connection).with('https://test.iqmetrix.com') { connection }
        TestUrlConnection.get('/examples', params: { 'test': '123' })
      end
    end

    describe 'when only the prefix is set on the class' do
      it 'sets up the url and prepends the prefix to the path' do
        expect(connection).to receive(:get).with('/test/v1/examples', params: { test: '123' })
        expect(CovaApi).to receive(:connection).with('https://api.covasoft.net') { connection }
        TestPrefixConnection.get('/examples', params: { 'test': '123' })
      end
    end
  end
end
