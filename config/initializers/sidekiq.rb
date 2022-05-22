require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}/#{ENV.fetch('REDIS_SIDEKIQ_DB', 0)}"}
  
  schedule_file = "config/schedule.yml"

  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_URL']}:#{ENV['REDIS_PORT']}/#{ENV.fetch('REDIS_SIDEKIQ_DB', 0)}"}
end