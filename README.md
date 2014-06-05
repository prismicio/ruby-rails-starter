## Ruby on Rails starter project for prismic.io

This is a blank Rails project that will connect to any [prismic.io](https://prismic.io)
repository, and trivially list its documents. It uses the prismic.io Ruby developement kit, and provides a few helpers
to better use it with Rails.

### Getting started

#### Launch the starter project

*(Assuming you've installed the latest versions of [Ruby](https://www.ruby-lang.org/en/downloads/), [Rails](http://rubyonrails.org/download) and [RubyGems](http://rubygems.org/pages/download).)*

After forking and cloning the starter kit, it is immediately operational, so you can launch your `rails server` command. You may have to update your gems by running `bundle install`, but Rails will tell you about it if you must.

#### Configuring

By default, the starter kit uses the public API of the "Les Bonnes Choses" repository; its endpoint is `https://lesbonneschoses.prismic.io/api`. You may want to start by editing the `config/prismic.yml` file to make your Rails application use your own prismic.io repository.

To get the OAuth configuration working (and be able to preview your future content release, as well as to access your API if it's private), go to the Applications panel in your repository settings, and create an OAuth application to allow interactive sign-in. Fill the application name and the callback URL (localhost URLs are always authorized, so at development time you can omit to fill the Callback URL field), and copy/paste the clientId & clientSecret tokens into the `config/prismic.yml` file.

You may have to restart your Rails server.

#### Get started with prismic.io

You can find out [how to get started with prismic.io](https://developers.prismic.io/documentation/UjBaQsuvzdIHvE4D/getting-started) on our [prismic.io developer's portal](https://developers.prismic.io/).

#### Understand the Ruby development kit

You'll find more information about how to use the development kit included in this starter project, by reading [its README file](https://github.com/prismicio/ruby-kit/blob/master/README.md).

### Specifics and helpers of the Rails starter project

There are several places in this project where you'll be able to find helpful helpers of many kinds. You may want to learn about them in order to know your starter project better, or to take those that you think might be useful to you in order to integrate prismic.io in an existing app.

 * in `app/controllers/prismic_controller.rb`:
   * its role: providing a module you can use as a mixin in your controllers to make it trivial to use prismic.io in your actions.
   * provides the `api` method to instantiate your `Prismic::Api` object once per HTTP request.
   * provides the `ref` method, retuning the ref id being currently queried, even if it's the master ref. To be used to call the API, for instance: `api.create_search_form('everything').submit(ref)`.
   * provides the `maybe_ref` method, returning the ref id being queried, or nil if it is the master ref. To be used where you want nothing if on master, but something if on another release, for instance: `root_path(ref: maybe_ref)`.
 * in `app/controllers/prismic_oauth_controller.rb`:
   * provides all necessary controller actions to have the OAuth pages working: signin, signout, callback, ...
 * in `config/routes.rb`:
   * the routes to the OAuth pages: signin, signout, callback, ...
 * in `app/helpers/prismic_helper.rb`:
   * provides a basic `link_resolver(ref)` method to iterate upon. For a given document, the `link_resolver` method describes its URL on your front-office. You really should edit this method, so that it supports all the document types your content writers might link to (read the very last paragraph of [our API documentation](https://developers.prismic.io/documentation/UjBe8bGIJ3EKtgBZ/api-documentation) to learn more about what link_resolver is for).
   * provides `api`, `ref` and `maybe_ref` method, just like in the `PrismicController` module, to be used in the views.
   * ...
 * in `config/prismic.yml` : centralizes all information about the prismic.io repository's API (endpoint, client ID, client secret, ...)
 * in `app/models/prismic_service.rb`:
   * provides `slug_checker(document, slug)`, which checks a provided slug against a document.
   * provides `get_document(id, api, ref)`, which retrieves the document from its id.
   * provides a number of other methods that some other helpers rely on (`access_token`, `config`, `init_api`, ...). If you're integrating prismic.io into an existing project, you really want that file.
 * in `config/initializers/prismic_custom.rb`:
   * allows you may customize the Ruby kit's behavior here.
   *out-of-the-box allows you to write `as_html_safe(link_resolver(maybe_ref))` in your views, instead of having to write `as_html(link_resolver(maybe_ref)).html_safe`.
 * we've also included some basic pages by default, with their routes, controllers and views:
   * the "index" page displays all documents, paginated by 20, and lists them as links towards their "document" pages.
   * "document" pages display a whole document in a trivial way.
   * "search" pages are search results.
 * in `app/views/layouts/application.html.erb`, all those pages contain the necessary UI components to have the OAuth working out of the box: signing in, signing out, selectbox to change the previewed content release, ...

### Other technical operations

#### Work with a local database

You don't actually need a database to run this starter project, as prismic.io handles everything for you (content, users, ...); if your website is all about content, you may never even need a database at all! Therefore, our starter project comes without ActiveRecord (the part of Rails that handles the connection with databases, and the model tier)

However, if your project offers other features than displaying content, you may need to store and retrieve non-content data from a local database. Here's how you put ActiveRecord back in your Rails starter project:

 * Comment-out the 4 `require` statements at the top of [application.rb](https://github.com/prismicio/ruby-rails-starter/blob/5224b130316ffb3b4ad8d10b49043fa3ab867eae/config/application.rb), replace them with `require 'rails/all'`.
 * Add the gem for the kind of database you have in mind to use (you can un-comment-out [the one we left for SQLite](https://github.com/prismicio/ruby-rails-starter/blob/5224b130316ffb3b4ad8d10b49043fa3ab867eae/Gemfile#L7), but we advise you to rather use the kind of database you will use in production).
 * create your `config/database.yml` file, which entirely depends on the kind of database you'll be using. Here are [exemples of usual database.yml files](https://gist.github.com/erichurst/961978), but you should rather check the documentation for the database gem you're using.
 * Un-comment-out the `ActiveRecord::Migration.check_pending!` line we left for you in [test_helper.rb](https://github.com/prismicio/ruby-rails-starter/blob/5224b130316ffb3b4ad8d10b49043fa3ab867eae/test/test_helper.rb#L6).
 * Un-comment-out the `config.active_record.migration_error = :page_load` line we left for you in [test_helper.rb](https://github.com/prismicio/ruby-rails-starter/blob/5224b130316ffb3b4ad8d10b49043fa3ab867eae/config/environments/development.rb#L23).

#### Deploying your application

This starter project is immediately deployable on most hosting platforms that are compatible with Rails 4. To deploy it on [Heroku](https://www.heroku.com/), simply [create a Heroku account](https://id.heroku.com/signup/www-home-top), install the [Heroku Toolbelt](https://toolbelt.heroku.com/), and log into it by running `heroku login` in your terminal.

Then, go to your project's directory in your terminal, and run:

```
heroku create
git push heroku master
```

Now your site is live for the world to see!

### Contribute to the starter project

Contribution is open to all developer levels, read our "[Contribute to the official kits](https://developers.prismic.io/documentation/UszOeAEAANUlwFpp/contribute-to-the-official-kits)" documentation to learn more.

### Licence

This software is licensed under the Apache 2 license, quoted below.

Copyright 2013 Zengularity (http://www.zengularity.com).

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this project except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
