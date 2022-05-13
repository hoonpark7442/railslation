module Feeds
  class ImportFeedsWorker
    include Sidekiq::Worker

    sidekiq_options queue: :medium_priority, retry: 10

    def perform(user_ids = [], earlier_than = nil)
      puts "hoon sidekiq worker"
      # if user_ids.present?
      #   users = User.where(id: user_ids)
      #   # we assume that forcing a single import should not take into account
      #   # the last time a feed was fetched at
      #   earlier_than = nil
      # else
      #   users = nil
      #   earlier_than ||= 4.hours.ago
      # end

      # ::Feeds::Import.call(users: users, earlier_than: earlier_than)
    end
  end
end
