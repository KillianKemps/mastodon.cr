require "http/client"
require "json"

module Mastodon
  module REST
    module Accounts
      ACCOUNTS_BASE = "/api/v1/accounts"

      def account(id)
        response = get("#{ACCOUNTS_BASE}/#{id}")
        Entities::Account.from_json(response)
      end

      def verify_credentials
        response = get("#{ACCOUNTS_BASE}/verify_credentials")
        Entities::Account.from_json(response)
      end

      def update_credentials(display_name = "", note = "", avatar = "", header = "")
        # avatar & header : image/jpeg, image/png, image/gif
        forms = HTTP::Params.build do |form|
          form.add "display_name", "#{display_name}" unless display_name.empty?
          form.add "note", "#{note}" unless note.empty?
          form.add "avatar", Utils::Image.base64_encode(avatar) unless avatar.empty?
          form.add "header",  Utils::Image.base64_encode(avatar) unless header.empty?
        end
        raise ArgumentError.new("Incorrect updating data") if forms.empty?
        response = patch("#{ACCOUNTS_BASE}/update_credentials", forms)
        Entities::Account.from_json(response)
      end

      def followers(id, max_id = nil, since_id = nil, limit = ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != ACCOUNTS_LIMIT && limit <= ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/followers", params)
        Collection(Entities::Account).from_json(response)
      end

      def following(id, max_id = nil, since_id = nil, limit = ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != ACCOUNTS_LIMIT && limit <= ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/following")
        Collection(Entities::Account).from_json(response)
      end

      def statuses(id, only_media = false, exclude_replies = false, max_id = nil, since_id = nil, limit = STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "only_media", "" if only_media
          param.add "exclude_replies", "" if exclude_replies
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != STATUSES_LIMIT && limit <= STATUSES_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/statuses", params)
        Collection(Entities::Status).from_json(response)
      end

      {% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute", "mute_boosts", "unmute_boosts"} %}
      def {{ method.id }}(id)
        response = post("#{ACCOUNTS_BASE}/#{id}/{{ method.id }}")
        Entities::Relationship.from_json(response)
      end
      {% end %}

      def relationships(ids : Int32 | Array(Int32))
        params = HTTP::Params.build do |param|
          param.add "id[]", "#{ids}" if ids.is_a?(Int32)
          ids.map { |id| param.add "id[]", "#{id}" } if ids.is_a?(Array(Int32))
        end
        response = get("#{ACCOUNTS_BASE}/relationships", params)
        Collection(Entities::Relationship).from_json(response)
      end

      def search_accounts(name, limit = ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "q", "#{name}"
          param.add "limit", "#{limit}" if limit != ACCOUNTS_LIMIT && limit <= ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/search", params)
        Collection(Entities::Account).from_json(response)
      end
    end
  end
end
