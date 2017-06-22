require "../client"
require "./api"
require "./oauth"

module Mastodon
  module REST
    class Error < Mastodon::Error; end

    class Client < Mastodon::Client
      include Mastodon::REST::Api
      include Mastodon::REST::OAuth

      def get(path : String, params : String | Hash(String, String) = "")
        params = HTTP::Params.encode(params) if params.is_a?(Hash)
        path += "?#{params}" unless params.empty?
        response = @http_client.get(path, default_headers)
        proccess_response(response)
      end

      def post(path : String, form : String | Hash(String, String) = "")
        response = @http_client.post_form(path, form, default_headers)
        proccess_response(response)
      end

      def post_formdata(path : String, form_data : Utils::MultipartFormData)
        headers = HTTP::Headers{
          "Content-Length" => "#{form_data.size}",
          "Content-Type" => "#{form_data.content_type}"
        }
        response = @http_client.post(path, headers.merge!(default_headers), form_data.io.to_slice)
        proccess_response(response)
      end

      def patch(path : String, form : String | Hash(String, String) = "")
        form = HTTP::Params.encode(form) if form.is_a?(Hash)
        headers = HTTP::Headers{"Content-type" => "application/x-www-form-urlencoded"}
        response = @http_client.patch(path, headers.merge!(default_headers), form)
        proccess_response(response)
      end

      def patch_formdata(path : String, form_data : Utils::MultipartFormData)
        headers = HTTP::Headers{
          "Content-Length" => "#{form_data.size}",
          "Content-Type" => "#{form_data.content_type}"
        }
        response = @http_client.patch(path, headers.merge!(default_headers), form_data.io.to_slice)
        proccess_response(response)
      end

      def delete(path : String, form : String | Hash(String, String) = "")
        form = HTTP::Params.encode(form) if form.is_a?(Hash)
        headers = HTTP::Headers{"Content-type" => "application/x-www-form-urlencoded"}
        response = @http_client.delete(path, headers.merge!(default_headers), form)
        proccess_response(response)
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
