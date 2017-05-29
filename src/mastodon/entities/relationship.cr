require "json"

module Mastodon
  module Entities
    class Relationship

      JSON.mapping({
        id: Int64,
        following: Bool,
        followed_by: Bool,
        blocking: Bool,
        muting: Bool,
        # muting_boosts: Bool,
        requested: Bool,
        domain_blocking: Bool,
      })

    end
  end
end
