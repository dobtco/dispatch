CarrierWave.configure do |config|
  if DispatchConfiguration.upload_storage == 'aws'
    config.storage = :aws
    config.cache_dir = Dir.tmpdir
    config.aws_credentials = {
      access_key_id: DispatchConfiguration.aws_key,
      secret_access_key: DispatchConfiguration.aws_secret,
      region: DispatchConfiguration.aws_region
    }
    config.aws_bucket = DispatchConfiguration.aws_bucket
    config.aws_attributes = {
      cache_control: 'max-age=315576000'
    }
    config.aws_authenticated_url_expiration = 60 * 60 # one hour
  else
    config.storage = :file
  end
end
