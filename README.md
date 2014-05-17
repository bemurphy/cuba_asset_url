# CubaAssetUrl

Plugin for Cuba to use signature asset urls.  This allows you to cache your
css/js assets and prevents browsers from getting stuck with old assets on
new deploys.

The plugin makes an assumption that, your app has a file in root named
`assets.json` that looks somthing like this:

```json
{
  "all.css": "/compiled/all-8c18cbb0.css",
  "all.js": "/compiled/all-d41d8cd98.js"
}
```

You can organize your assets how you wish, but the layout should reference
assets from this manifest file.

You can generate the signature files with a process like that found in the
gist at https://gist.github.com/bemurphy/23ed00cc4f28676e28ca.

## Installation

Add this line to your application's Gemfile:

    gem 'cuba_asset_url'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cuba_asset_url

## Usage

In production/staging, enable via `ENV['USE_ASSET_SIGNATURES'] = true`

Load the plugin like any other Cuba plugin:

```ruby
Cuba.plugin CubaAssetUrl
```

In your template, use the `css_url` and `js_url` helpers for the path to
the asset:

```html
<link href="<%= css_url(:all) %>" rel="stylesheet">

<script src="<%= js_url(:all) %>"></script>
```

The argument is the name of the attribute key in the manifest file.  `:all` is
a nice convention but not required.

If you aren't set to use asset_signatures, the paths returned will have the
signature parts stripped out.

```
/compiled/foo-af134d.css
```

becomes
```
/compiled/foo.css
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/cuba_asset_url/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
