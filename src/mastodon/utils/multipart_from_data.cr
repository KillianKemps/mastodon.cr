require "http/multipart"

module Mastodon
  module Utils
    class MultipartFormData
      @multipart : HTTP::Multipart::Builder

      getter io : IO::Memory

      def initialize
        @io = IO::Memory.new
        @multipart = HTTP::Multipart::Builder.new(@io)
      end

      def add(name, string)
        @multipart.body_part content_disposition_header(name), string
      end

      def add_file(name, filename, file : File)
        image_io = IO::Memory.new
        IO.copy(file, image_io)
        @multipart.body_part content_disposition_header(name, filename), image_io.to_slice
      end

      def finish
        @multipart.finish
      end

      def content_type
        "multipart/form-data; boundary=#{@multipart.boundary}"
      end

      private def content_disposition_header(name)
        HTTP::Headers{"content-disposition" => "form-data; name=\"#{name}\""}
      end

      private def content_disposition_header(name, filename)
        HTTP::Headers{"content-disposition" => "form-data; name=\"#{name}\"; filename=\"#{filename}\""}
      end

      delegate size, to: @io
      delegate boundary, to: @multipart
    end
  end
end
