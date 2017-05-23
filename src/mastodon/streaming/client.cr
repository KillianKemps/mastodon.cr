require "http/client"
require "./error"

module Mastodon
  module Streaming
    class Client < Mastodon::Client
      STREAMING_BASE = "/api/v1/streaming"

      def user(&block : Entities::Status | Entities::Notification -> )
        proccess_streaming("#{STREAMING_BASE}/user") do |event, data|
          case event
          when "update"
            yield Entities::Status.from_json(data)
          when "notification"
            yield Entities::Notification.from_json(data)
          when "delete"
            next
          else
            next
          end
        end
      end

      def public(&block : Entities::Status -> )
        stream("#{STREAMING_BASE}/public") do |object|
          yield object
        end
      end

      def hashtag(hashtag, &block : Entities::Status -> )
        stream("#{STREAMING_BASE}/#{hashtag}") do |object|
          yield object
        end
      end

      private def proccess_streaming(path : String)
        @http_client.get(path) do |response|
          case response.status_code
          when 200
            while true
              begin
                line = response.body_io.read_line
                next if line =~ /^(\s+|:thump|)$/
                if line && line =~ /^event: /
                  data_line = response.body_io.read_line
                  if data_line && data_line =~ /^data: /
                    event = line["event: ".size..-1]
                    data  = data_line["data: ".size..-1]
                    yield event, data
                  end
                end
              rescue # IO::EOFError
                break
              end
            end
          else
            raise Streaming::Error.new(response)
          end
        end
      end

      private def stream(path, &block : Entities::Status -> )
        proccess_streaming(path) do |event, data|
          case event
          when "update"
            yield Entities::Status.from_json(data)
          when "delete"
            next
          else
            next
          end
        end
      end
    end
  end
end
