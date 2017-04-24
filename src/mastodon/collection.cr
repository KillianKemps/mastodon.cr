module Mastodon
  class Collection(T) < Array(T)
    def next_id
      self.min_of { |item| item.id }
    end

    def prev_id
      self.max_of { |item| item.id }
    end
  end
end
