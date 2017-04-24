require "../../spec_helper"

def timeline_home(max_id = nil, since_id = nil, limit = 20)
  params = HTTP::Params.build do |param|
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 20 && limit <= 40
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/timelines/home#{query}", "statuses")
  client.timeline_home(max_id, since_id, limit)
end

def timeline_public(local = false, max_id = nil, since_id = nil, limit = 20)
  params = HTTP::Params.build do |param|
    param.add "local", "" if local
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 20 && limit <= 40
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/timelines/public#{query}", "statuses")
  client.timeline_public(local, max_id, since_id, limit)
end

def timeline_tag(hashtag, local = false, max_id = nil, since_id = nil, limit = 20)
  params = HTTP::Params.build do |param|
    param.add "local", "" if local
    param.add "max_id", "#{max_id}" unless max_id.nil?
    param.add "since_id", "#{since_id}" unless since_id.nil?
    param.add "limit", "#{limit}" if limit != 20 && limit <= 40
  end
  query = "?#{params}" unless params.empty?
  stub_get("/api/v1/timelines/tag/#{hashtag}#{query}", "statuses")
  client.timeline_tag(hashtag, local, max_id, since_id, limit)
end

describe Mastodon::REST::Client do
  describe ".timeline_home(max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Status)" do
      timeline_home().should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe ".timeline_public(local, max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Status)" do
      timeline_public().should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end

  describe ".timeline_tag(hashtag, local, max_id, since_id, limit)" do
    it "Response should be a Mastodon::Collection(Mastodon::Entities::Status)" do
      timeline_tag("hashtag").should be_a Mastodon::Collection(Mastodon::Entities::Status)
    end
  end
end
