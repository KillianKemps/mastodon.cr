module Mastodon
  module REST
    module OAuth
      def authenticate(access_token : String)
        @access_token = OAuth2::AccessToken::Bearer.new(access_token, 172_800)
        @access_token.not_nil!.authenticate(@http_client)
      end

      def authenticate(access_token : OAuth2::AccessToken::Bearer)
        @access_token = access_token
        @access_token.not_nil!.authenticate(@http_client)
      end

      def get_access_token_using_username_password(client_id = "", client_secret = "", scopes = "read", username = "", password = "") : OAuth2::AccessToken::Bearer
        response = post("/oauth/token", {
          "client_id" => client_id,
          "client_secret" => client_secret,
          "scope" => scopes,
          "grant_type" => "password",
          "username" => username,
          "password" => password
        })
        token = Entities::Auth::AccessToken.from_json(response)
        OAuth2::AccessToken::Bearer.new(token.access_token, 172_800, nil, token.scope)
      end

      def get_access_token_using_code(client_id = "", client_secret = "", scopes = "read", code = "", redirect_uri = "urn:ietf:wg:oauth:2.0:oob") : OAuth2::AccessToken::Bearer
        response = post("/oauth/token", {
          "client_id" => client_id,
          "client_secret" => client_secret,
          "scope" => scopes,
          "grant_type" => "authorization_code",
          "code" => code,
          "redirect_uri" => redirect_uri
        })
        token = Entities::Auth::AccessToken.from_json(response)
        OAuth2::AccessToken::Bearer.new(token.access_token, 172_800, nil, token.scope)
      end

      def oauth_url(client_id = "", scopes = "read", redirect_uri = "urn:ietf:wg:oauth:2.0:oob") : String
        params = HTTP::Params.build do |form|
          form.add "response_type", "code"
          form.add "client_id", client_id
          form.add "scope", scopes
          form.add "redirect_uri", redirect_uri
        end
        "https://#{@url}/oauth/authorize?&#{params}"
      end
    end
  end
end
