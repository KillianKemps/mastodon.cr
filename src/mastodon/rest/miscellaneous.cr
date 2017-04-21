require "http/client"
require "json"

module Mastodon
  module REST
    module Miscellaneous
      def blocks(max_id = nil, since_id = nil, limit = Accounts::DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != Accounts::DEFAULT_ACCOUNTS_LIMIT && limit <= 80
        end
        response = get("/api/v1/blocks", params)
        Array(Mastodon::Response::Account).from_json(response)
      end

      def favourites(max_id = nil, since_id = nil, limit = Statuses::DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != Statuses::DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("/api/v1/favourites")
        Array(Mastodon::Response::Status).from_json(response)
      end

      def follow_requests(max_id = nil, since_id = nil, limit = Accounts::DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != Accounts::DEFAULT_ACCOUNTS_LIMIT && limit <= 80
        end
        response = get("/api/v1/follow_requests", params)
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

      def mutes(max_id = nil, since_id = nil, limit = Accounts::DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != Accounts::DEFAULT_ACCOUNTS_LIMIT && limit <= 80
        end
        response = get("/api/v1/mutes", params)
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
