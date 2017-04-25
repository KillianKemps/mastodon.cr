require "../../spec_helper"

describe Mastodon::Utils::Image do
  describe ".mime_type(filename)" do
    describe "png" do
      subject { Mastodon::Utils::Image.mime_type("avatar.png") }
      it "should equal `image/png`" do
        expect(subject).to eq "image/png"
      end
    end
    describe "jepg" do
      subject { Mastodon::Utils::Image.mime_type("avatar.jpg") }
      it "should equal `image/jpeg`" do
        expect(subject).to eq "image/jpeg"
      end
    end
    describe "other" do
      subject { Mastodon::Utils::Image.mime_type("avatar.gif") }
      it "should be nil" do
        expect(subject).to be_nil
      end
    end
  end

  describe ".base64_encode(filename)" do
    subject { Mastodon::Utils::Image.base64_encode(fixture_image("icon.png")) }
    it "should match data:image/png;base64,..." do
      expect(subject).to match /^data:image\/png;base64,.+=$/
    end
  end
end
