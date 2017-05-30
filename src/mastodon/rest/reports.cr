require "http/client"
require "json"

module Mastodon
  module REST
    module Reports
      def reports
        response = get("/api/v1/reports")
        Collection(Entities::Report).from_json(response)
      end

      def report(account_id, status_ids : Int32 | Array(Int32), comment = "")
        forms = HTTP::Params.build do |form|
          form.add "account_id", "#{account_id}"
          form.add "status_ids[]", "#{status_ids}" if status_ids.is_a?(Int32)
          status_ids.map { |id| form.add "status_ids[]", "#{id}" } if status_ids.is_a?(Array(Int32))
          form.add "comment", "#{comment}"
        end
        response = post("/api/v1/reports", forms)
        Entities::Report.from_json(response)
      end
    end
  end
end
