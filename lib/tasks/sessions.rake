namespace :sessions do
  desc "Clear Rails.sessions"
  task :clear do
    ActiveSupport::Cache.lookup_store(Rails.configuration.cache_‌​store).clear
    puts "Successfully cleared Rails.sessions!"
  end
end