# CubaAssetUrl

Plugin for Cuba to use signature asset urls.  This allows you to cache your
css/js assets and prevents browsers from getting stuck with old assets on
new deploys.

The plugin makes an assumption that, your app has a file in root named
`assets.json` that looks somthing like this:

```json
{
  "all.css": "/compiled/all-8c18cbb09b70c847500da8818bac816f.css",
  "all.js": "/compiled/all-d41d8cd98f00b204e9800998ecf8427e.js"
}
```

You may of course organize your assets among multiple files however you wish,
but the layout should reference assets from this manifest file.

You can generate the signature files with a process like that found in the
gist at https://gist.github.com/bemurphy/23ed00cc4f28676e28ca

## Installation

Add this line to your application's Gemfile:

    gem 'cuba_asset_url'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cuba_asset_url

## Usage

In production/staging, enable via `ENV['USE_ASSET_SIGNATURES'] = true`

In your template, use the `css_url` and `js_url` for the path to the asset:

```html
<link href="<%= css_url(:all) %>" rel="stylesheet">

<script src="<%= js_url(:all) %>"></script>
```

The argument is the name of the attribute key in the manifest file.  `:all` is
a nice convention but you can change this if you wish.

If you aren't set to use asset_signatures, the config will be rebuilt to default
to the same path but with the signature bit stripped out.  So

```
/compiled/foo-af134d.css
```

becomes
```
/compiled/foo.css
```

## Todo

Probably it would be better to not assume the assets but rather pass a path
to the helper.  This would enable people who prefer a `public/script` or
`public/styles` directory.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/cuba_asset_url/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
