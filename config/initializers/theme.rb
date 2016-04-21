def require_if_exists(path)
  require(path) if File.exist?(path)
end

# Require theme's simple_form configuration
require_if_exists BeaconConfiguration.theme_path.join('simple_form.rb')

# Add theme assets to the beginning of the sprockets load path
Rails.configuration.assets.paths =
  Dir[BeaconConfiguration.theme_path.join("assets/**/*")] +
  Rails.configuration.assets.paths
