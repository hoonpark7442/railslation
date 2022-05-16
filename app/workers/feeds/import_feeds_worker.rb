module Feeds
  class ImportFeedsWorker
    include Sidekiq::Worker

    sidekiq_options queue: :medium_priority, retry: 10

    def perform(author_ids = [])
      # if author_ids.present?
      #   authors = Author.where(id: author_ids)
      # else
      #   authors = nil
      # end

      # ::Feeds::Import.call(authors: authors)
      ::Feeds::Import.call
    end
  end
end
