require "../../spec_helper"

describe Mastodon::REST::Media do
  describe ".media_upload(filename)" do
    before do
      WebMock.stub(:post, "https://#{client.url}/api/v1/media").
        with(headers: {"Authorization" => "Bearer token"}).
        to_return(body: load_fixture("attachment"))
    end
    subject { client.media_upload(fixture_image("icon.png")) }
    it "Response should be a Mastodon::Entities::Attachment" do
      expect(subject).to be_a Mastodon::Entities::Attachment
    end
  end
end
