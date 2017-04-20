require "json"

module Mastodon
  module Response
    class Account

      JSON.mapping({
        id: Int32,
        username: String,
        acct: String,
        display_name: String,
        locked: Bool,
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        followers_count: Int32,
        following_count: Int32,
        statuses_count: Int32,
        note: String,
        url: String,
        avatar: String,
        avatar_static: String,
        header: String,
        header_static: String,
      })

      def_equals id
    end
  end
end
