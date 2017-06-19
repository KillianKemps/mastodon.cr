require "../client"

module Mastodon
  module Streaming
    class Error < Mastodon::Error; end

    class Client < Mastodon::Client
      private STREAMING_BASE = "/api/v1/streaming"

      @on_update_callback = ->(status : Entities::Status) { }
      @on_notification_callback = ->(notification : Entities::Notification) { }
      @on_delete_callback = ->(id : Int32) { }

      def user(&block : Entities::Status | Entities::Notification | Int32 -> )
        stream("#{STREAMING_BASE}/user") do |object|
          yield object
        end
      end

      def public(&block : Entities::Status | Int32 -> )
        stream("#{STREAMING_BASE}/public") do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def hashtag(hashtag, &block : Entities::Status | Int32 -> )
        stream("#{STREAMING_BASE}/#{hashtag}") do |object|
          yield object if object.is_a?(Entities::Status | Int32)
        end
      end

      def on_update(&block : Entities::Status ->)
        @on_update_callback = block
      end

      def on_notification(&block : Entities::Notification ->)
        @on_notification_callback = block
      end

      def on_delete(&block : Int32 ->)
        @on_delete_callback = block
      end

      def user
        stream("#{STREAMING_BASE}/user")
      end

      def public
        stream("#{STREAMING_BASE}/public")
      end

      def hashtag(hashtag)
        stream("#{STREAMING_BASE}/#{hashtag}")
      end

      private def stream(path, &block : Entities::Status | Entities::Notification | Int32 -> )
        proccess_streaming(path) do |event, data|
          case event
          when "update"
            yield Entities::Status.from_json(data)
          when "notification"
            yield Entities::Notification.from_json(data)
          when "delete"
            yield data.to_i
          else
            next
          end
        end
      end

      private def stream(path)
        proccess_streaming(path) do |event, data|
          case event
          when "update"
            @on_update_callback.call(Entities::Status.from_json(data))
          when "notification"
            @on_notification_callback.call(Entities::Notification.from_json(data))
          when "delete"
            @on_delete_callback.call(data.to_i)
          else
            next
          end
        end
      end

      private def proccess_streaming(path : String)
        @http_client.get(path, default_headers) do |response|
          case response.status_code
          when 200
            begin
              while line = response.body_io.read_line
                next if line =~ /^(\s+|:thump|)$/
                if line && line =~ /^event: /
                  data_line = response.body_io.read_line
                  if data_line && data_line =~ /^data: /
                    event = line["event: ".size..-1]
                    data  = data_line["data: ".size..-1]
                    yield event, data
                  end
                end
              end
            rescue # IO::EOFError
              break
            end
          else
            raise Streaming::Error.new(response)
          end
        end
      end
    end
  end
end
