# frozen_string_literal: true

require 'oauth2'

module CovaApi
  class MissingAuthentication < StandardError; end

  AUTH_URL = 'https://accounts.iqmetrix.net'
  AUTH_ENDPOINT = '/v1/oauth2/token'

  class << self
    def authenticate(username:, password:, client_id:, client_secret:, company_id:, token_hash: nil)
      @credentials = {
        username: username, password: password, client_id: client_id, client_secret: client_secret,
        company_id: company_id
      }
      client = OAuth2::Client.new client_id, client_secret, site: AUTH_URL, token_url: AUTH_ENDPOINT
      @token = if token_hash
                 OAuth2::AccessToken.from_hash(client, token_hash)
               else
                 client.password.get_token(username, password)
               end
      @token.to_hash
    end

    def token
      raise MissingAuthentication unless @credentials

      authenticate(@credentials) unless @token
      @token = @token.refresh! if @token.expired?
      @token.to_hash
    rescue OAuth2::Error
      authenticate @credentials
    end

    def company_id
      raise MissingAuthentication unless @credentials

      @credentials[:company_id]
    end

    def connection(site)
      raise MissingAuthentication unless @credentials

      client = OAuth2::Client.new @credentials[:client_id], @credentials[:client_secret], site: site
      OAuth2::AccessToken.from_hash(client, token)
    end

    def logout(server: true)
      Faraday.get "#{AUTH_URL}/logout", { access_token: @token.token } if server
      @credentials = nil
      @token = nil
    end
  end
end
