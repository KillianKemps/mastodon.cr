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

      getter   url : String
      getter!  access_token : OAuth2::AccessToken::Bearer?
      property user_agent : String = "mastodon.cr/#{Mastodon::VERSION}"

      def initialize(url : String)
        @url = url
        @http_client = HTTP::Client.new(@url, tls: true)
      end

      def initialize(url : String, access_token : String)
        @url = url
        @http_client = HTTP::Client.new(@url, tls: true)
        authenticate(access_token)
      end

      def get(path : String, params : String | Hash(String, String) = "")
        params = HTTP::Params.from_hash(params) if params.is_a?(Hash)
        path += "?#{params}" unless params.empty?
        response = @http_client.get(path, defuault_headers)
        proccess_response(response)
      end

      def post(path : String, form : String | Hash(String, String) = "")
        response = @http_client.post_form(path, form, defuault_headers)
        proccess_response(response)
      end

      def patch(path : String, form : String | Hash(String, String) = "")
        form = HTTP::Params.from_hash(form) if form.is_a?(Hash)
        headers = HTTP::Headers{"Content-type" => "application/x-www-form-urlencoded"}
        response = @http_client.patch(path, headers.merge!(defuault_headers), form)
        proccess_response(response)
      end

      def delete(path : String)
        response = @http_client.delete(path, defuault_headers)
        proccess_response(response)
      end

      private def defuault_headers
        HTTP::Headers{"User-Agent" => "#{@user_agent}"}
      end

      private def proccess_response(response : HTTP::Client::Response)
        case response.status_code
          when 200..299
            return response.body
          else
            raise REST::Error.new(response)
        end
      end
    end
  end
end
