# Spree Multi Vendor

This is a spree [multi vendor marketplace](https://getvendo.com) extension. It's a great starting point if you're building a marketplace on top of [Spree](https://spreecommerce.org). Our goal was flexibility to allow you to tweak it to your needs.

## Developed by

[![Vendo](https://cdn.getvendo.com/assets/vendo-logo-4bda02af8c99bc2ecc5a400120f0ebe4eafcd385e02e25f198a8c355ab75d1ff.png)](https://www.getvendo.com/marketplace-platform)

> All-in-one platform for all your multi-vendor Marketplace needs. [Get started](https://www.getvendo.com/get-started?utm_source=spree_multi_vendor_github)

## Open source vs Vendo

If you need a product that has all of the features out of the box, such us supplier onboarding, Stripe connect payment splitting and payouts, and don't require any custom development - we recommend using [Vendo](https://www.getvendo.com/marketplace-platform).

| feature | open source | [vendo] |
|---|---|---|
| basic vendorization | ✔️ | ✔️ |
| supplier onboarding | | ✔️ |
| supplier dashboard | | ✔️ |
| supplier management | | ✔️ |
| supplier product curation | | ✔️ |
| automatic payment splitting | | ✔️ |
| automatic payouts | | ✔️ |
| Afterpay / klarna / apple pay | | ✔️ |
| shopify / bigcommerce / woocommerce integration | | ✔️ |
| USPS, UPS, FedEx, DHL, and more | | ✔️ |
| bulk upload / import of products from CSV and XSLX | | ✔️ |
| bulk export of orders, shipments and more | | ✔️ |

## Installation

1. Add this extension to your Gemfile with this line:
    ```ruby
    gem 'spree_multi_vendor'
    ```

2. Install the gem using Bundler:
    ```ruby
    bundle install
    ```

3. Copy & run migrations
    ```ruby
    bundle exec rails g spree_multi_vendor:install
    ```

4. Restart your server

    If your server was running, restart it so that it can find the assets properly.

5. Optionally you can also create sample Vendor by running:

   ```bash
   bundle exec rake spree_multi_vendor:sample:create
   ```

## Upgrading

1. Fetch new database migrations:

    ```bash
    bundle exec rake railties:install:migrations FROM=spree_multi_vendor
    ```

2. Run migrations

    ```bash
    bundle exec rails db:migrate
    ```

## Configuration

To change which models should be vendorized, in your Spree initializer (`config/initializers/spree.rb`) add:

```ruby
SpreeMultiVendor::Config[:vendorized_models] = %w[product variant stock_location shipping_method other_model]
```

This will lookup for `Spree::OtherModel` class. To add `vendor_id` column to that model run:

```bash
bundle exec rails g migration AddVendorToSpreeOtherModels vendor:references
```

## API endpoints

Spree Multi Vendor adds new [API v2](https://api.spreecommerce.org/docs/api-v2/api/docs/v2/storefront/index.yaml) endpoints:

1. `GET` Display Vendor information endpoint
    
     ```
     /api/v2/storefront/vendors/<vendor_slug>
     ```
     
     eg. `/api/v2/storefront/vendors/test-vendor`

     you can also include Vendor image and/or Products in that call:

     `/api/v2/storefront/vendors/test-vendor?include=image,products`

2. `GET` Returns a list of Vendors
    
     ```
     /api/v2/storefront/vendors
     ```    

     you can also include Vendor image and/or Products in that call:

     `/api/v2/storefront/vendors?include=image,products`


And modfies existing:

1. `GET` Filtering Products by Vendor ID(s):

    ```
    /api/v2/storefront/products?filter[vendor_ids]=1,2,3
    ```

2. `GET` Include Vendor information in Cart endpoint:

    ```
    /api/v2/storefront/cart?include=vendors,vendor_totals
    ```

## Email previews

Spree offers emails preview generator for development purposes.
To generate them, use command:

`bundle exec rails g spree_multi_vendor:mailers_preview`

After that, start rails server locally and go to:
`localhost:3000/rails/mailers`

(it requires seeded development database in order to work properly)

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_multi_vendor/factories'
```

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

## License

Spree Multi-Vendor is copyright © 2017-2023
[Vendo Connect Inc][vendo]. It is free software,
and may be redistributed under the terms specified in the
[LICENCE](LICENSE) file.

[LICENSE]: https://github.com/spree-contrib/spree_multi_vendor/blob/main/LICENSE

## About Vendo

> [Vendo][vendo] is a great fit for marketplaces of all sizes - either with its own fulfillment and multiple warehouses or in a dropshipping model. Vendo **automates everything** from **vendor onboarding**, accepting buyer **payments in over 135 currencies**, to supplier **payouts in 50 countries**. 

> Vendo ensures excellent buyer experience with smooth product discovery and search, many payment methods, and optimal shipping cost calculation. Vendo keeps suppliers happy with easy onboarding, automated product sync using their preferred method, and easy payouts.

> [Get started](https://www.getvendo.com/get-started)

[vendo]:https://www.getvendo.com/marketplace-platform
