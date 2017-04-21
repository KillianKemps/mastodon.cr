require "http/client"
require "json"

module Mastodon
  module REST
    module Accounts
      ACCOUNTS_BASE = "/api/v1/accounts"
      DEFAULT_ACCOUNTS_LIMIT = 40

      def account(id)
        response = get("#{ACCOUNTS_BASE}/#{id}")
        Mastodon::Response::Account.from_json(response)
      end

      def verify_credentials
        response = get("#{ACCOUNTS_BASE}/verify_credentials")
        Mastodon::Response::Account.from_json(response)
      end

      def update_credentials(display_name = "", note = "", avatar = "", header = "")
        forms = HTTP::Params.build do |form|
          form.add "display_name", "#{display_name}" unless display_name.empty?
          form.add "note", "#{note}" unless note.empty?
          form.add "avatar", Mastodon::Utils::Image.base64_encode(avatar) unless avatar.empty?
          form.add "header",  Mastodon::Utils::Image.base64_encode(avatar) unless header.empty?
        end
        raise ArgumentError.new("Incorrect updating data") if forms.empty?
        response = patch("#{ACCOUNTS_BASE}/update_credentials", forms)
        Mastodon::Response::Account.from_json(response)
      end

      def followers(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= 80
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/followers", params)
        Array(Mastodon::Response::Account).from_json(response)
      end

      def following(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= 80
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/following")
        Array(Mastodon::Response::Account).from_json(response)
      end

      def statuses(id, only_media = false, exclude_replies = false, max_id = nil, since_id = nil, limit = Statuses::DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "only_media", "" if only_media
          param.add "exclude_replies", "" if exclude_replies
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != Statuses::DEFAULT_STATUSES_LIMIT && limit <= 80
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/statuses", params)
        Array(Mastodon::Response::Status).from_json(response)
      end

      {% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute"} %}
      def {{ method.id }}(id)
        response = post("#{ACCOUNTS_BASE}/#{id}/{{ method.id }}")
        Mastodon::Response::Relationship.from_json(response)
      end
      {% end %}

      def relationships(ids : Int32 | Array(Int32))
        params = HTTP::Params.build do |param|
          case ids
            when Int32
              param.add "id", "#{ids}"
            when Array(Int32)
              ids.each do |id|
                param.add "id[]", "#{id}"
              end
          end
        end
        response = get("#{ACCOUNTS_BASE}/relationships", params)
        Array(Mastodon::Response::Relationship).from_json(response)
      end

      def search_accounts(name, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "q", "#{name}"
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= 80
        end
        response = get("#{ACCOUNTS_BASE}/search", params)
        Array(Mastodon::Response::Account).from_json(response)
      end
    end
  end
end
