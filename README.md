# CubaAssetUrl

Plugin for Cuba to use signature asset urls.  This allows you to cache your
css/js assets and prevents browsers from getting stuck with old assets on
new deploys.

The plugin makes a few simple assumptions:

1. You serve a single css file from `/css/app.css`
2. You serve a single js file from `/js/app.js`
3. You have a file in root named `assets.json` that looks somthing like this:

```json
{
  "app.css": "/css/app-8c18cbb09b70c847500da8818bac816f.css",
  "app.js": "/js/app-d41d8cd98f00b204e9800998ecf8427e.js"
}
```

You may of course organize your assets among multiple files however you wish,
but the layout should only reference the two assets.

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
<link href="<%= css_url %>" rel="stylesheet">

<script src="<%= js_url %>"></script>

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
