DobtAuth.configure do |config|
  config.app_id = ENV['DOBT_APP_ID'].to_i
  config.api_key = ENV['DOBT_API_KEY']
  config.secret_key = ENV['DOBT_SECRET_KEY']
end
