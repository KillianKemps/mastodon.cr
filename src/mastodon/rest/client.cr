require "http/client"
require "json"
require "oauth2"
require "./api"
require "./oauth"
require "./error"

module Mastodon
  module REST
    class Client
      include Mastodon::REST::Api
      include Mastodon::REST::OAuth

      getter  url : String
      getter! access_token : OAuth2::AccessToken::Bearer?

      def initialize(url : String)
        @url = url
        @http_client = HTTP::Client.new(@url, tls: true)
      end

      def initialize(url : String, access_token : String)
        @url = url
        @http_client = HTTP::Client.new(@url, tls: true)
        authenticate(access_token)
      end

      def get(path : String, params : String | Hash(String, String) = "") : String
        params = HTTP::Params.from_hash(params) if params.is_a?(Hash)
        path += "?#{params}" unless params.empty?
        response = @http_client.get(path)
        proccess_response(response)
      end

      def post(path : String, form : String | Hash(String, String) = "") : String
        response = @http_client.post_form(path, form)
        proccess_response(response)
      end

      def patch(path : String, form : String | Hash(String, String) = "") : String
        form = HTTP::Params.from_hash(form) if form.is_a?(Hash)
        response = @http_client.patch(path, HTTP::Headers{"Content-type" => "application/x-www-form-urlencoded"}, form)
        proccess_response(response)
      end

      def delete(path : String) : String
        response = @http_client.delete(path)
        proccess_response(response)
      end

      private def proccess_response(response : HTTP::Client::Response) : String
        case response.status_code
          when 200..299
            return response.body
          else
            raise REST::Error.new(response)
        end
        return "{}"
      end
    end
  end
end
