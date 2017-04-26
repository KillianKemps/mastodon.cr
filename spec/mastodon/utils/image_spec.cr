require "../../spec_helper"

describe Mastodon::Utils::Image do
  describe ".mime_type(filename)" do
    describe "with png file" do
      subject { Mastodon::Utils::Image.mime_type("avatar.png") }
      it "is equal `image/png`" do
        expect(subject).to eq "image/png"
      end
    end
    describe "with jpg file" do
      subject { Mastodon::Utils::Image.mime_type("avatar.jpg") }
      it "is equal `image/jpeg`" do
        expect(subject).to eq "image/jpeg"
      end
    end
    describe "with other" do
      subject { Mastodon::Utils::Image.mime_type("avatar.gif") }
      it "is nil" do
        expect(subject).to be_nil
      end
    end
  end

  describe ".base64_encode(filename)" do
    subject { Mastodon::Utils::Image.base64_encode(fixture_image("icon.png")) }
    it "is match data:image/png;base64,..." do
      expect(subject).to match /^data:image\/png;base64,.+=$/
    end
  end
end
