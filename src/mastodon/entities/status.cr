require "json"
require "./attachment"
require "./mention"
require "./account"
require "./tag"
require "./status"

module Mastodon
  module Entities
    class Status

      JSON.mapping({
        id: Int32,
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        in_reply_to_id: { type: Int32, nilable: true },
        in_reply_to_account_id: { type: Int32, nilable: true },
        sensitive: { type: Bool, nilable: true },
        spoiler_text: String,
        visibility: String,
        application: { type: Entities::Application, nilable: true },
        account: Entities::Account,
        media_attachments: { type: Array(Entities::Attachment), nilable: true },
        mentions: { type: Array(Entities::Mention), nilable: true },
        tags: { type: Array(Entities::Tag), nilable: true },
        uri: String,
        content: String,
        url: String,
        reblogs_count: Int32,
        favourites_count: Int32,
        reblog: { type: Entities::Status, nilable: true },
        #favourited:,
        #reblogged:,
      })

      def_equals id
    end
  end
end
