require "cuba_asset_url/version"
require "json"

module CubaAssetUrl
  def self.setup(app)
    config = JSON[File.read('assets.json')]

    if ENV['USE_ASSET_SIGNATURES'] == 'true'
      app.settings[:assets_config] = config
    else
      app.settings[:assets_config] = {}
      config.each do |k, v|
        stripped = v.gsub(/-[a-f0-9]+\.(js|css)$/, ".\\1")
        app.settings[:assets_config][k] = stripped
      end
    end
  end

  def css_url(name)
    settings[:assets_config]["#{name}.css"]
  end

  def js_url(name)
    settings[:assets_config]["#{name}.js"]
  end
end
