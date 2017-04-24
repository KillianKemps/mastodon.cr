require "json"

module Mastodon
  module Entities
    class Report

      JSON.mapping({
        id: Int32,
        action_taken: Bool
      })

      def_equals id
    end
  end
end
