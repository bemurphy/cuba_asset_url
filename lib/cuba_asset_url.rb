require "cuba_asset_url/version"
require "json"

module CubaAssetUrl
  def self.setup(app)
    if ENV['USE_ASSET_SIGNATURES'] == 'true'
      app.settings[:assets_config] = JSON[File.read('assets.json')]
    else
      app.settings[:assets_config] = {
        'app.css' => '/css/app.css',
        'app.js'  => '/js/app.js',
      }
    end
  end

  def css_url
    settings[:assets_config]['app.css']
  end

  def js_url
    settings[:assets_config]['app.js']
  end
end
