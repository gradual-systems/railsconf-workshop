# Rails 5 Setup

If you're using Rails 5, some things might not work for you!

To make sure `packwerk` continues to work on Rails 5 for you, modify your `bin/packwerk` binstub by placing the following above `load Gem.bin_path("packwerk", "packwerk")`

```ruby
module Packwerk
  module ApplicationLoadPaths
    class << self
      def extract_relevant_paths(*args)
        # A simple hack to bypass changing Rails APIs in Rails 6+.
        # Here we hard-code the most common paths.
        paths = Dir['app/*'] + Dir['app/*/concerns'] + Dir['packs/*/*'] + Dir['packs/*/*/concerns/']
        paths.map{|p| [p, Object]}.to_h
      end
    end
  end
end
```

Although this is not necessarily a recommended solution long-term, this should allow packwerk to work for you in Rails 5.

This should work because while `packwerk` doesn't actually specify a dependency on Rails 6 or above (see https://github.com/Shopify/packwerk/blob/main/packwerk.gemspec), it uses Rails 6 and above API. This monkey patch changes the offending code to use non-Rails API to get the load paths for packwerk (used for constant resolution).
