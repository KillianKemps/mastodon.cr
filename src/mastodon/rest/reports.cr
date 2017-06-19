require "http/client"
require "json"

module Mastodon
  module REST
    module Reports
      private REPORTS_BASE = "/api/v1/reports"

      def reports
        response = get("#{REPORTS_BASE}")
        Entities.from_response(response, Collection(Entities::Report))
      end

      def report(account_id, status_ids : Int32 | Array(Int32), comment = "")
        forms = HTTP::Params.build do |form|
          form.add "account_id", "#{account_id}"
          form.add "status_ids[]", "#{status_ids}" if status_ids.is_a?(Int32)
          status_ids.map { |id| form.add "status_ids[]", "#{id}" } if status_ids.is_a?(Array(Int32))
          form.add "comment", "#{comment}"
        end
        response = post("#{REPORTS_BASE}", forms)
        Entities.from_response(response, Entities::Report)
      end
    end
  end
end
