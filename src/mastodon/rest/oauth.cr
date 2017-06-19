module Mastodon
  module REST
    module OAuth
      def get_access_token_using_username_password(client_id = "", client_secret = "", scopes = "read", username = "", password = "") : OAuth2::AccessToken::Bearer
        response = post("/oauth/token", {
          "client_id" => client_id,
          "client_secret" => client_secret,
          "scope" => scopes,
          "grant_type" => "password",
          "username" => username,
          "password" => password
        })
        token = Entities.from_response(response, Entities::Auth::AccessToken)
        OAuth2::AccessToken::Bearer.new(token.access_token, 172_800, nil, token.scope)
      end

      def get_access_token_using_authorization_code(client_id = "", client_secret = "", scopes = "read", code = "", redirect_uri = "urn:ietf:wg:oauth:2.0:oob") : OAuth2::AccessToken::Bearer
        response = post("/oauth/token", {
          "client_id" => client_id,
          "client_secret" => client_secret,
          "scope" => scopes,
          "grant_type" => "authorization_code",
          "code" => code,
          "redirect_uri" => redirect_uri
        })
        token = Entities.from_response(response, Entities::Auth::AccessToken)
        OAuth2::AccessToken::Bearer.new(token.access_token, 172_800, nil, token.scope)
      end

      def authorize_uri(client_id = "", scopes = "read", redirect_uri = "urn:ietf:wg:oauth:2.0:oob") : String
        client = OAuth2::Client.new(
          @http_client.host,
          client_id,
          "",
          authorize_uri: "/oauth/authorize",
          redirect_uri: redirect_uri
        )
        client.get_authorize_uri(scopes)
      end
    end
  end
end
