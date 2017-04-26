require "../../spec_helper"

describe Mastodon::REST::Media do
  describe ".media_upload(filename)" do
    before do
      WebMock.stub(:post, "https://#{client.url}/api/v1/media").
        with(headers: {"Authorization" => "Bearer token", "User-Agent" => "mastodon.cr/0.1.0"}).
        to_return(body: load_fixture("attachment"))
    end
    subject { client.media_upload(fixture_image("icon.png")) }
    it "is a Mastodon::Entities::Attachment" do
      expect(subject).to be_a Mastodon::Entities::Attachment
    end

    describe "with invalid file" do
      subject { client.media_upload(fixture_image("foo.png")) }
      it "raise ArgumentError" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
