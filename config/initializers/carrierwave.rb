CarrierWave.configure do |config|
  if Rails.configuration.x.carrierwave_storage == :aws
    config.storage = :aws
    config.cache_dir = Dir.tmpdir
    config.aws_credentials = {
      access_key_id: ENV['AWS_KEY'],
      secret_access_key: ENV['AWS_SECRET'],
      region: ENV['AWS_REGION']
    }
    config.aws_bucket = ENV['AWS_BUCKET']
    config.aws_attributes = {
      cache_control: 'max-age=315576000'
    }
    config.aws_authenticated_url_expiration = 60 * 60 # one hour
  else
    config.storage = :file
  end
end
