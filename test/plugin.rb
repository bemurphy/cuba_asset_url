require "cutest"
require "cuba"
require "cuba_asset_url"

Cuba.define do
  on default do
    res.write "#{css_url}, #{js_url}"
  end
end

scope do
  prepare do
    ENV['USE_ASSET_SIGNATURES'] = 'false'
    Cuba.plugin CubaAssetUrl
  end

  test "asset urls are defaults" do
    _, _, body = Cuba.call({ 'PATH_INFO' => '/', 'SCRIPT_NAME' => '' })
    assert_equal "/css/app.css, /js/app.js", body[0]
  end
end

scope do
  prepare do
    ENV['USE_ASSET_SIGNATURES'] = 'true'

    def File.read(name)
      assert_equal 'assets.json', name

      {'app.css' => '/css/app-123.css', 'app.js' => '/js/app-456.js'}.to_json
    end

    Cuba.plugin CubaAssetUrl
  end

  test "asset urls contain signatures from the asset.json" do
    _, _, body = Cuba.call({ 'PATH_INFO' => '/', 'SCRIPT_NAME' => '' })
    assert_equal "/css/app-123.css, /js/app-456.js", body[0]
  end
end
