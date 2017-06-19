require "./accounts"
require "./apps"
require "./blocks"
require "./domain_blocks"
require "./favourites"
require "./follow_requests"
require "./follows"
require "./instances"
require "./media"
require "./mutes"
require "./notifications"
require "./reports"
require "./search"
require "./statuses"
require "./timelines"

module Mastodon
  module REST
    module Api
      include Mastodon::REST::Accounts
      include Mastodon::REST::Apps
      include Mastodon::REST::Blocks
      include Mastodon::REST::DomainBlocks
      include Mastodon::REST::Favourites
      include Mastodon::REST::FollowRequests
      include Mastodon::REST::Follows
      include Mastodon::REST::Instances
      include Mastodon::REST::Media
      include Mastodon::REST::Mutes
      include Mastodon::REST::Notifications
      include Mastodon::REST::Reports
      include Mastodon::REST::Search
      include Mastodon::REST::Statuses
      include Mastodon::REST::Timelines
    end
  end
end
