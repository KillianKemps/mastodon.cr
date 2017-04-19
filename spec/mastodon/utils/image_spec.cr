require "../../spec_helper"

describe Mastodon::Utils::Image do
  describe ".mime_type(filename)" do
    it "should equal `image/png`" do
      Mastodon::Utils::Image.mime_type("avatar.png").should eq "image/png"
    end
    it "should equal `image/jpeg`" do
      Mastodon::Utils::Image.mime_type("avatar.jpg").should eq "image/jpeg"
      Mastodon::Utils::Image.mime_type("avatar.jpeg").should eq "image/jpeg"
    end
    it "should be nil" do
      Mastodon::Utils::Image.mime_type("avatar.gif").should be_nil
    end
  end

  describe ".base64_encode(filename)" do
    it "should match data:image/png;base64,..." do
      Mastodon::Utils::Image.base64_encode(fixture_image("icon.png")).should match /^data:image\/png;base64,.+=$/
    end
  end
end
