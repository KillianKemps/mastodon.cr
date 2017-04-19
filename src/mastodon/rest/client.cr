require "http/client"
require "json"
require "oauth2"
require "./api"

module Mastodon
  module REST
    class Client
      include Mastodon::REST::Api

      class ServerError < Exception; end

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

      def authenticate(access_token : String)
        @access_token = OAuth2::AccessToken::Bearer.new(access_token, 172_800)
        @access_token.not_nil!.authenticate(@http_client)
      end

      def get_access_token_using_username_password(client_id = "", client_secret = "", scopes = "read", username = "", password = "") : OAuth2::AccessToken::Bearer
        response_body = post("/oauth/token", {
          "client_id" => client_id,
          "client_secret" => client_secret,
          "scope" => scopes,
          "grant_type" => "password",
          "username" => username,
          "password" => password
        })
        json = JSON.parse(response_body)
        OAuth2::AccessToken::Bearer.new(json["access_token"].to_s, 172_800)
      end

      def get(path : String, params = {} of String => String) : String
        query = HTTP::Params.from_hash(params)
        get(path, query)
      end

      def get(path : String, params : String = "") : String
        path += "?#{params}" unless params.empty?
        response = @http_client.get(path)
        proccess_response(response)
      end

      def post(path : String, form = {} of String => String) : String
        response = @http_client.post_form(path, form)
        proccess_response(response)
      end

      def post(path : String, form : String = "") : String
        response = @http_client.post_form(path, form)
        proccess_response(response)
      end

      def patch(path : String, form = {} of String => String) : String
        body = HTTP::Params.from_hash(form)
        patch(path, body)
      end

      def patch(path : String, form : String = "") : String
        request = HTTP::Request.new("PATCH", path, nil, form).tap do |request|
          request.headers["Host"] = url
          request.headers["Content-type"] = "application/x-www-form-urlencoded"
        end
        response = @http_client.exec(request)
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
            process_error(response)
        end
        return "{}"
      end

      private def process_error(response : HTTP::Client::Response)
        case response.content_type
          when "application/json"
            error = Mastodon::Response::Error.from_json(response.body)
            raise Client::ServerError.new("#{response.status_code} #{error.error}")
          else
            raise Client::ServerError.new("#{response.status_code} #{response.status_message}")
        end
      end
    end
  end
end
