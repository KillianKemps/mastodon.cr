require "../../spec_helper"

describe Mastodon::Utils::Image do
  describe "#mime_type" do
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
    describe "with gif file" do
      subject { Mastodon::Utils::Image.mime_type("avatar.gif") }
      it "is equal `image/gif`" do
        expect(subject).to eq "image/gif"
      end
    end
    describe "with other" do
      subject { Mastodon::Utils::Image.mime_type("avatar.txt") }
      it "is nil" do
        expect(subject).to be_nil
      end
    end
  end
end
