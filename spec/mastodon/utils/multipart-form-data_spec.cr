require "../../spec_helper"

def multipart_form_data
  filename = fixture_image("icon.png")
  file = File.open(filename, "rb")
  Mastodon::Utils::MultipartFormData.new("file", File.basename(filename), file)
end

describe Mastodon::Utils::MultipartFormData do
  form_data = multipart_form_data

  describe ".content_type" do
    it "should match multipart/form-data; boundary=..." do
      form_data.content_type.should match /^multipart\/form-data; boundary=/
    end
  end

  describe ".size" do
    it "should equal IO size" do
      form_data.size.should eq form_data.io.size
    end
  end
end
