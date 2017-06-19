require "http/client"
require "json"

module Mastodon
  module REST
    module Statuses
      private STATUSES_BASE = "/api/v1/statuses"

      def status(id)
        # Does not require authentication
        response = get("#{STATUSES_BASE}/#{id}")
        Entities.from_response(response, Entities::Status)
      end

      def create_status(status, in_reply_to_id = nil, media_ids = [] of Int32, sensitive = false, spoiler_text = "", visibility = "")
        forms = HTTP::Params.build do |form|
          form.add "status", "#{status}"
          form.add "in_reply_to_id", "#{in_reply_to_id}" unless in_reply_to_id.nil?
          media_ids.map { |id| form.add "media_ids[]", "#{id}" }
          form.add "sensitive", "true" if sensitive
          form.add "spoiler_text", "#{spoiler_text}" unless spoiler_text.empty?
          form.add "visibility", "#{visibility}" if ["direct", "private", "unlisted", "public"].includes?(visibility)
        end
        response = post("#{STATUSES_BASE}", forms)
        Entities.from_response(response, Entities::Status)
      end

      def delete_status(id)
        delete("#{STATUSES_BASE}/#{id}")
        nil
      end

      def context(id)
        # Does not require authentication
        response = get("#{STATUSES_BASE}/#{id}/context")
        Entities.from_response(response, Entities::Context)
      end

      def card(id)
        # Does not require authentication
        response = get("#{STATUSES_BASE}/#{id}/card")
        Entities.from_response(response, Entities::Card)
      end

      {% for method in {"reblogged_by", "favourited_by"} %}
      def {{ method.id }}(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        # Does not require authentication
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{STATUSES_BASE}/#{id}/{{ method.id }}", params)
        Entities.from_response(response, Collection(Entities::Account))
      end
      {% end %}

      {% for method in {"reblog", "unreblog", "favourite", "unfavourite"} %}
      def {{ method.id }}(id)
        response = post("#{STATUSES_BASE}/#{id}/{{ method.id }}")
        Entities.from_response(response, Entities::Status)
      end
      {% end %}
    end
  end
end
