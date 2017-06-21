require "../../spec_helper"

describe Mastodon::Utils::MultipartFormData do
  let(filename) { fixture_image("icon.png") }
  let(file) { File.open(filename, "rb") }

  subject {
    multipart = Mastodon::Utils::MultipartFormData.new
    multipart.add_file("file", File.basename(filename), file)
    multipart.finish
    multipart
  }

  describe "#content_type" do
    it "is match multipart/form-data; boundary=..." do
      expect(subject.content_type).to match /^multipart\/form-data; boundary=/
    end
  end

  describe "#size" do
    it "is equal IO size" do
      expect(subject.size).to eq subject.io.size
    end
  end
end
