require "http/client"
require "json"

module Mastodon
  module REST
    module Accounts
      private ACCOUNTS_BASE = "/api/v1/accounts"

      def account(id)
        response = get("#{ACCOUNTS_BASE}/#{id}")
        Entities.from_response(response, Entities::Account)
      end

      def verify_credentials
        response = get("#{ACCOUNTS_BASE}/verify_credentials")
        Entities.from_response(response, Entities::Account)
      end

      def update_credentials(display_name = "", note = "", avatar = "", header = "")
        # avatar & header : image/jpeg, image/png, image/gif
        form_data = Utils::MultipartFormData.new
        form_data.add("display_name", "#{display_name}") unless display_name.empty?
        form_data.add("note", "#{note}") unless note.empty?
        unless avatar.empty?
          raise ArgumentError.new("File not found") unless File.file?(avatar)
          File.open(avatar, "rb") do |file|
            form_data.add_file("avatar", File.basename(avatar), file)
          end
        end
        unless header.empty?
          raise ArgumentError.new("File not found") unless File.file?(header)
          File.open(header, "rb") do |file|
            form_data.add_file("header", File.basename(header), file)
          end
        end
        form_data.finish
        response = patch_formdata("#{ACCOUNTS_BASE}/update_credentials", form_data)
        Entities.from_response(response, Entities::Account)
      end

      def followers(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/followers", params)
        Entities.from_response(response, Collection(Entities::Account))
      end

      def following(id, max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/following")
        Entities.from_response(response, Collection(Entities::Account))
      end

      def statuses(id, only_media = false, exclude_replies = false, max_id = nil, since_id = nil, limit = DEFAULT_STATUSES_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "only_media", "" if only_media
          param.add "exclude_replies", "" if exclude_replies
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_STATUSES_LIMIT && limit <= DEFAULT_STATUSES_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/#{id}/statuses", params)
        Entities.from_response(response, Collection(Entities::Status))
      end

      {% for method in {"follow", "unfollow", "block", "unblock", "mute", "unmute", "mute_boosts", "unmute_boosts"} %}
      def {{ method.id }}(id)
        response = post("#{ACCOUNTS_BASE}/#{id}/{{ method.id }}")
        Entities.from_response(response, Entities::Relationship)
      end
      {% end %}

      def relationships(ids : Int32 | Array(Int32))
        params = HTTP::Params.build do |param|
          param.add "id[]", "#{ids}" if ids.is_a?(Int32)
          ids.map { |id| param.add "id[]", "#{id}" } if ids.is_a?(Array(Int32))
        end
        response = get("#{ACCOUNTS_BASE}/relationships", params)
        Entities.from_response(response, Collection(Entities::Relationship))
      end

      def search_accounts(name, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "q", "#{name}"
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{ACCOUNTS_BASE}/search", params)
        Entities.from_response(response, Collection(Entities::Account))
      end
    end
  end
end
