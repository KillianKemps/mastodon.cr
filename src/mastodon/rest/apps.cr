require "http/client"
require "json"

module Mastodon
  module REST
    module Apps
      private APPS_BASE = "/api/v1/apps"

      def apps(client_name, redirect_uris = "urn:ietf:wg:oauth:2.0:oob", scopes = "read", website = "")
        response = post("#{APPS_BASE}", {
          "client_name" => client_name,
          "redirect_uris" => redirect_uris,
          "scopes" => scopes,
          "website" => website
        })
        Entities::Auth::App.from_json(response)
      end
    end
  end
end
