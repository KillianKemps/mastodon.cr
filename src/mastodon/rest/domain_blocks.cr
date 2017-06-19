require "http/client"
require "json"

module Mastodon
  module REST
    module DomainBlocks
      private DOMAIN_BLOCKS_BASE = "/api/v1/domain_blocks"

      def domain_blocks(max_id = nil, since_id = nil, limit = 40)
        params = HTTP::Params.build do |param|
          param.add "max_id", "#{max_id}" unless max_id.nil?
          param.add "since_id", "#{since_id}" unless since_id.nil?
          param.add "limit", "#{limit}" if limit != 40 && limit <= 40 * 2
        end
        response = get("#{DOMAIN_BLOCKS_BASE}", params)
        Entities.from_response(response, Collection(String))
      end

      def block_domain(domain)
        forms = HTTP::Params.build do |form|
          form.add "domain", "#{domain}"
        end
        post("#{DOMAIN_BLOCKS_BASE}", forms)
        nil
      end

      def unblock_domain(domain)
        forms = HTTP::Params.build do |form|
          form.add "domain", "#{domain}"
        end
        delete("#{DOMAIN_BLOCKS_BASE}", forms)
        nil
      end
    end
  end
end
