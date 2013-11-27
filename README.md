## Prismic.io starter for Ruby on Rails

This is a blank Rails project that will connect to any [prismic.io](https://prismic.io)
repository. It uses the prismic.io Ruby developement kit, and provides few helpers
to use it with Rails.

### How to start?

If you haven't yet, install the latest versions of [Ruby](https://www.ruby-lang.org/en/downloads/), [Rails](http://rubyonrails.org/download) and [RubyGems](http://rubygems.org/pages/download).

After forking and cloning the starter kit, it is immediately operational, so you can launch your `rails server` command. You may have to update your gems by running `bundle install`, but Rails will tell you about it if you must.

The output of your `rails server` command tells you which URL to visit on your browser to see your brand new prismic.io Rails application.

### Configuring

By default, the starter kit uses the public API of the "Les Bonnes Choses" repository; its endpoint is `https://lesbonneschoses.prismic.io/api`. You may want to start by editing the `config/prismic.yml` file to make your Rails application points to your prismic.io repository.

To get the OAuth configuration working, go to the Applications panel in your repository settings, and create an OAuth application to allow interactive sign-in. Just create a new application, fill the application name and the callback URL (localhost URLs are always authorized, so at development time you can omit to fill the Callback URL field), and copy/paste the clientId & clientSecret tokens into the `config/prismic.yml` file.

### Starter Kit Documentation

You should check out [the "Kits and helpers" section of our API documentation](https://developers.prismic.io/documentation/UjBe8bGIJ3EKtgBZ/api-documentation#kits-and-helpers), which sets general information about how our kits work, and [the "Kit documentation" of the Ruby development kit](https://github.com/prismicio/ruby-kit) for specifics about how the gem works.

Below are some extra helpers included in this starter kit to make your life easier.
 * There's no need for a `ctx` object to pass around: the API object can be retrieved through the `api` method of the controller (which initializes it if it wasn't), and `@ref` is an instance variable that is set before every call to the controller.
 * A `PrismicService` class is included, which comes with a few interesting methods, including `PrismicService.get_document(id,api,@ref)` to make a quicker query from an ID. For instance, you can call a bookmarked document really easily: `PrismicService.get_document(api.bookmark('home'),api,@ref)`
 * A `PrismicHelper` module is also provided, that provides several interesting methods to use in views, including a basic `link_resolver` method to be used out of the box (read more about this method in our "Kits and helpers" documentation).

### Licence

This software is licensed under the Apache 2 license, quoted below.

Copyright 2013 Zengularity (http://www.zengularity.com).

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this project except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
