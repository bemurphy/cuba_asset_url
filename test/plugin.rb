require "cutest"
require "cuba"
require "cuba_asset_url"

Cuba.define do
  on 'defaults' do
    res.write "#{css_url(:foo)}, #{js_url(:bar)}"
  end

  on 'signatures' do
    res.write "#{css_url(:all)}, #{js_url(:all)}"
  end
end

scope do
  prepare do
    ENV['USE_ASSET_SIGNATURES'] = 'false'

    def File.read(name)
      assert_equal 'assets.json', name

      {'foo.css' => '/compiled/foo-123.css', 'bar.js' => '/compiled/bar-456.js'}.to_json
    end

    Cuba.plugin CubaAssetUrl
  end

  test "asset urls are defaults" do
    _, _, body = Cuba.call({ 'PATH_INFO' => '/defaults', 'SCRIPT_NAME' => '' })
    assert_equal "/compiled/foo.css, /compiled/bar.js", body[0]
  end
end

scope do
  prepare do
    ENV['USE_ASSET_SIGNATURES'] = 'true'

    def File.read(name)
      assert_equal 'assets.json', name

      {'all.css' => '/compiled/all-123.css', 'all.js' => '/compiled/all-456.js'}.to_json
    end

    Cuba.plugin CubaAssetUrl
  end

  test "asset urls contain signatures from the asset.json" do
    _, _, body = Cuba.call({ 'PATH_INFO' => '/signatures', 'SCRIPT_NAME' => '' })
    assert_equal "/compiled/all-123.css, /compiled/all-456.js", body[0]
  end
end
