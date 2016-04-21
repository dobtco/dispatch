def require_if_exists(path)
  require(path) if File.exist?(path)
end

require_if_exists BeaconConfiguration.theme_path.join('simple_form.rb')
