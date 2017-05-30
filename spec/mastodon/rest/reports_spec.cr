require "../../spec_helper"

describe Mastodon::REST::Reports do
  let(client) { Mastodon::REST::Client.new("example.com", "token") }

  describe "#reports" do
    before do
      stub_get("/api/v1/reports", "reports")
    end
    subject { client.reports }
    it "is a Mastodon::Collection(Mastodon::Entities::Report)" do
      expect(subject).to be_a Mastodon::Collection(Mastodon::Entities::Report)
    end
  end

  describe "#report" do
    before do
      forms = HTTP::Params.build do |form|
        form.add "account_id", "1"
        form.add "status_ids[]", "1"
        form.add "status_ids[]", "2"
        form.add "status_ids[]", "3"
        form.add "comment", ""
      end
      stub_post("/api/v1/reports", "report", forms)
    end
    subject { client.report(1, [1, 2, 3], "") }
    it "is a Mastodon::Entities::Report" do
      expect(subject).to be_a Mastodon::Entities::Report
    end
  end
end
