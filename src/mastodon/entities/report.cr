require "json"

module Mastodon
  module Entities
    class Report

      JSON.mapping({
        id: Int64,
        action_taken: Bool
      })

      def_equals id
    end
  end
end
