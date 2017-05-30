require "http/client"
require "oauth2"

module Mastodon
  class Client
    getter   url : String
    getter!  access_token : OAuth2::AccessToken::Bearer?
    property user_agent : String = "mastodon.cr/#{Mastodon::VERSION}"

    def initialize(url : String)
      @url = url
      @http_client = HTTP::Client.new(@url, tls: true)
    end

    def initialize(url : String, access_token : String | OAuth2::AccessToken::Bearer)
      @url = url
      @http_client = HTTP::Client.new(@url, tls: true)
      authenticate(access_token)
    end

    def authenticate(access_token : String)
      @access_token = OAuth2::AccessToken::Bearer.new(access_token, 172_800)
      @access_token.not_nil!.authenticate(@http_client)
    end

    def authenticate(access_token : OAuth2::AccessToken::Bearer)
      @access_token = access_token
      @access_token.not_nil!.authenticate(@http_client)
    end

    private def default_headers
      HTTP::Headers{"User-Agent" => "#{@user_agent}"}
    end
  end
end
