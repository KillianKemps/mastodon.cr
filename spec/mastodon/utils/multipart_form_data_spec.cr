require "../../spec_helper"

describe Mastodon::Utils::MultipartFormData do
  subject {
    filename = fixture_image("icon.png")
    file = File.open(filename, "rb")
    Mastodon::Utils::MultipartFormData.new("file", File.basename(filename), file)
  }

  describe ".content_type" do
    it "is match multipart/form-data; boundary=..." do
      expect(subject.content_type).to match /^multipart\/form-data; boundary=/
    end
  end

  describe ".size" do
    it "is equal IO size" do
      expect(subject.size).to eq subject.io.size
    end
  end
end
