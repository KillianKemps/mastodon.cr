require "../../spec_helper"

def media_upload
  WebMock.stub(:post, "https://#{client.url}/api/v1/media").
    with(headers: {"Authorization" => "Bearer token"}).
    to_return(body: load_fixture("attachment"))
  client.media_upload(fixture_image("icon.png"))
end

describe Mastodon::REST::Client do
  describe ".media_upload(filename)" do
    it "Response should be a Mastodon::Response::Attachment" do
      media_upload.should be_a Mastodon::Response::Attachment
    end
  end
end
