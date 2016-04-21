CarrierWave.configure do |config|
  if Configuration.upload_storage == 'aws'
    config.storage = :aws
    config.cache_dir = Dir.tmpdir
    config.aws_credentials = {
      access_key_id: Configuration.aws_key,
      secret_access_key: Configuration.aws_secret,
      region: Configuration.aws_region
    }
    config.aws_bucket = Configuration.aws_bucket
    config.aws_attributes = {
      cache_control: 'max-age=315576000'
    }
    config.aws_authenticated_url_expiration = 60 * 60 # one hour
  else
    config.storage = :file
  end
end
