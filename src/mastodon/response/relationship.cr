require "json"

module Mastodon
  module Response
    class Relationship

      JSON.mapping({
        id: Int32,
        following: Bool,
        followed_by: Bool,
        blocking: Bool,
        muting: Bool,
        requested: Bool,
      })

    end
  end
end
