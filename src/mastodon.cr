require "./mastodon/*"
require "./mastodon/entities/**"
require "./mastodon/utils/**"
require "./mastodon/rest/**"
require "./mastodon/streaming/**"

module Mastodon
  ACCOUNTS_LIMIT = 40
  STATUSES_LIMIT = 20
  NOTIFICATIONS_LIMIT = 15
end
