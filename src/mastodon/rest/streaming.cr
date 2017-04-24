require "http/client"
require "json"

module Mastodon
  module REST
    module Streaming
      STREAMING_BASE = "/api/v1/streaming"

      def proccess_streaming(path : String)
        @http_client.get(path) do |response|
          case response.status_code
            when 200
              while true
                lines = response.body_io.gets("\n\n")
                next if lines =~ /^\s+$/
                if lines
                  ary = lines.split(/\n/)
                  ary.delete_at(0) if ary[0] =~ /:thump/
                  yield ary[0].lchop("event: "), ary[1].lchop("data: ")
                end
              end
            else
              raise REST::Error.new(response)
          end
        end
      end

      private def get_stream(path)
        proccess_streaming(path) do |event, data|
          case event
            when "update"
              yield Entities::Status.from_json(data), nil
            when "notification"
              yield nil, Entities::Notification.from_json(data)
            when "delete"
              # TODO
              next
            else
              next
          end
        end
      end

      def streaming_home
        get_stream("#{STREAMING_BASE}/user") do |status, notification|
          yield status, notification
        end
      end

      def streaming_public
        get_stream("#{STREAMING_BASE}/public") do |status|
          yield status
        end
      end

      def streaming_tag(hashtag)
        get_stream("#{STREAMING_BASE}/#{hashtag}") do |status|
          yield status
        end
      end
    end
  end
end
