def require_if_exists(path)
  require(path) if File.exist?(path)
end

# Require theme's simple_form configuration
require_if_exists BeaconConfiguration.theme_path.join('simple_form.rb')

# Add theme assets to the beginning of the sprockets load path
Rails.configuration.assets.paths =
  Dir[BeaconConfiguration.theme_path.join("assets/**/*")] +
  Rails.configuration.assets.paths

Rails.configuration.i18n.load_path +=
  Dir[BeaconConfiguration.theme_path.join('locales/**/*')]

Dir[BeaconConfiguration.theme_path.join('submission_adapters/**/*')].each do |f|
  require f
end
