require "http/client"
require "json"

module Mastodon
  module REST
    module Miscellaneous
      def blocks
        response = get("/api/v1/blocks")
        Array(Mastodon::Response::Account).from_json(response)
      end

      def favourites
        response = get("/api/v1/favourites")
        Array(Mastodon::Response::Status).from_json(response)
      end

      def follow_requests
        response = get("/api/v1/follow_requests")
        Array(Mastodon::Response::Account).from_json(response)
      end

      def authorize_follow_request(id)
        post("/api/v1/follow_requests/#{id}/authorize")
      end

      def reject_follow_request(id)
        post("/api/v1/follow_requests/#{id}/reject")
      end

      def follows(username)
        response = post("/api/v1/follows", { "uri" => "#{username}" })
        Mastodon::Response::Account.from_json(response)
      end

      def instance
        response = get("/api/v1/instance")
        Mastodon::Response::Instance.from_json(response)
      end

      def mutes
        response = get("/api/v1/mutes")
        Array(Mastodon::Response::Account).from_json(response)
      end

      def reports
        response = get("/api/v1/reports")
        Array(Mastodon::Response::Report).from_json(response)
      end

      def report(account_id, status_ids : Int32 | Array(Int32), comment = "")
        forms = HTTP::Params.build do |form|
          form.add "account_id", "#{account_id}"
          case status_ids
            when Int32
              form.add "status_ids[]", "#{status_ids}"
            when Array(Int32)
              status_ids.each do |status_id|
                form.add "status_ids[]", "#{status_id}"
              end
          end
          form.add "comment", "#{comment}"
        end
        response = post("/api/v1/reports", forms)
        Mastodon::Response::Report.from_json(response)
      end
    end
  end
end
