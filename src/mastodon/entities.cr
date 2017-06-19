module Mastodon
  module Entities
    def self.from_response(response, klass)
      klass.from_json(response)
    end
  end
end
