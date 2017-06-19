require "http/multipart"

module Mastodon
  module Utils
    class MultipartFormData
      getter io : IO::Memory
      getter size : Int32
      @boundary : String

      def initialize(name, filename, file)
        image_io = IO::Memory.new
        IO.copy(file, image_io)

        @io = IO::Memory.new
        multipart = HTTP::Multipart::Builder.new(@io)
        multipart.body_part content_disposition_header(name, filename), image_io.to_slice
        multipart.finish

        @boundary = multipart.boundary
        @size = @io.size
      end

      def content_type
        "multipart/form-data; boundary=#{@boundary}"
      end

      private def content_disposition_header(name, filename)
        HTTP::Headers{"content-disposition" => "form-data; name=\"#{name}\"; filename=\"#{filename}\""}
      end
    end
  end
end
