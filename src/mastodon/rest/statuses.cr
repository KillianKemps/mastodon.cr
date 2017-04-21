require "http/client"
require "json"

module Mastodon
  module REST
    module Statuses
      STATUSES_BASE = "/api/v1/statuses"
      DEFAULT_STATUSES_LIMIT = 20

      def status(id)
        response = get("#{STATUSES_BASE}/#{id}")
        Mastodon::Response::Status.from_json(response)
      end

      def create_status(status, in_reply_to_id = nil, media_ids = [] of Int32, sensitive = false, spoiler_text = "", visibility = "")
        forms = HTTP::Params.build do |form|
          form.add "status", "#{status}"
          form.add "in_reply_to_id", "#{in_reply_to_id}" unless in_reply_to_id.nil?
          unless media_ids.empty?
            media_ids.each do |id|
              form.add "media_ids[]", "#{id}"
            end
          end
          form.add "sensitive", "true" if sensitive
          form.add "spoiler_text", "#{spoiler_text}" unless spoiler_text.empty?
          form.add "visibility", "#{visibility}" if ["direct", "private", "unlisted", "public"].includes?(visibility)
        end
        response = post("#{STATUSES_BASE}", forms)
        Mastodon::Response::Status.from_json(response)
      end

      def delete_status(id)
        delete("#{STATUSES_BASE}/#{id}")
      end

      def card(id)
        response = get("#{STATUSES_BASE}/#{id}/card")
        Mastodon::Response::Card.from_json(response)
      end

      def context(id)
        response = get("#{STATUSES_BASE}/#{id}/context")
        Mastodon::Response::Context.from_json(response)
      end

      {% for method in {"reblogged_by", "favourited_by"} %}
      def {{ method.id }}(id, max_id = nil, since_id = nil, limit = Accounts::DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != Accounts::DEFAULT_ACCOUNTS_LIMIT && limit <= 80
        end
        response = post("#{STATUSES_BASE}/#{id}/{{ method.id }}", params)
        Array(Mastodon::Response::Account).from_json(response)
      end
      {% end %}

      {% for method in {"reblog", "unreblog", "favourite", "unfavourite"} %}
      def {{ method.id }}(id)
        response = post("#{STATUSES_BASE}/#{id}/{{ method.id }}")
        Mastodon::Response::Status.from_json(response)
      end
      {% end %}
    end
  end
end
