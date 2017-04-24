require "json"
require "./attachment"
require "./mention"
require "./account"
require "./tag"
require "./status"

module Mastodon
  module Response
    class Status

      JSON.mapping({
        id: Int32,
        created_at: { type: Time, converter: Time::Format.new("%Y-%m-%dT%T") },
        in_reply_to_id: { type: Int32, nilable: true },
        in_reply_to_account_id: { type: Int32, nilable: true },
        sensitive: { type: Bool, nilable: true },
        spoiler_text: String,
        visibility: String,
        application: { type: Response::Application, nilable: true },
        account: Response::Account,
        media_attachments: { type: Array(Response::Attachment), nilable: true },
        mentions: { type: Array(Response::Mention), nilable: true },
        tags: { type: Array(Response::Tag), nilable: true },
        uri: String,
        content: String,
        url: String,
        reblogs_count: Int32,
        favourites_count: Int32,
        reblog: { type: Response::Status, nilable: true },
        #favourited:,
        #reblogged:,
      })

      def_equals id
    end
  end
end
