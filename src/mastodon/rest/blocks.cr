require "http/client"
require "json"

module Mastodon
  module REST
    module Blocks
      private BLOCKS_BASE = "/api/v1/blocks"

      def blocks(max_id = nil, since_id = nil, limit = DEFAULT_ACCOUNTS_LIMIT)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != DEFAULT_ACCOUNTS_LIMIT && limit <= DEFAULT_ACCOUNTS_LIMIT * 2
        end
        response = get("#{BLOCKS_BASE}", params)
        Entities.from_response(response, Collection(Entities::Account))
      end
    end
  end
end
