require "base64"

module Mastodon
  module Utils
    module Image
      extend self

      def mime_type(finename)
        case File.extname(finename)
          when ".png"
            "image/png"
          when ".jpg", ".jpeg"
            "image/jpeg"
          else
            nil
        end
      end

      def base64_encode(filename)
        raise ArgumentError.new("File not found") unless File.file?(filename)
        mime_type = mime_type(filename)
        raise ArgumentError.new("File type mismatch") if mime_type.nil?
        File.open(filename, "rb") do |file|
          io = IO::Memory.new
          IO.copy(file, io)
          "data:#{mime_type};base64," + Base64.strict_encode(io)
        end
      end
    end
  end
end
