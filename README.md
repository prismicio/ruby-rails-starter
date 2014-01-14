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

#### Specifics and sugar of the Rails starter kit

There are several places where you'll be able to find helpful helpers of many kinds. All is documented in the source code, but here's an overview of the most important parts, so you get to know your starter kit better:
 * in `config/initializers/prismic_custom.rb`:
  * you may customize the Ruby kit's behavior here (for instance, how it serializes fragments in HTML).
  * out-of-the-box allows you to write `as_html_safe(link_resolver(@maybe_ref))` in your views, instead of having to write `as_html(link_resolver(@maybe_ref)).html_safe`.
 * in `app/models/prismic_service.rb`:
  * provides `slug_checker(document, slug)`, which checks a provided slug against a document.
  * provides `get_document(id, api, ref)`, which retrieves the document from its id.
  * ...
 * in `app/helpers/prismic_helper.rb`:
  * provides a basic `link_resolver(ref)` method. For a given document, the `link_resolver` method describes its URL on your front-office. You really should edit this method, so that it supports all the document types your users might link to.
  * ...
 * in `app/controllers/application_controller.rb`:
  * initializes and provides `@api`, through the `api` method (it also exists in `prismic_helper.rb`, so you can also use it as `api` in your views).
  * initializes @ref, the ref id being currently queried, even if it's the master ref. To be used to call the API, for instance: `api.create_search_form('everything').submit(@ref)`.
  * initializes @maybe_ref, the ref id being queried, or nil if it is the master ref. To be used where you want nothing if on master, but something if on another release, for instance: `root_path(ref: @maybe_ref)` or `document_link(@maybe_ref)`.
  * provides all necessary controller actions to have the OAuth pages working (signin, signout, callback, ...).
 * pages by default:
  * the "index" page displays all documents, paginated by 20, and lists them as links towards their "document" pages.
  * "document" pages call Prismic::Document#as_html_safe (HTML serialisation of all the document's fragments in order).
  * "search" pages are search results.
  * in `app/views/layouts/application.html.erb`, all those pages contain the necessary UI components to have the OAuth working out of the box: signing in, signing out, changing content releases, ... Of course, you can customize those components.

#### Get started with prismic.io

You can find out [how to get started with prismic.io](https://developers.prismic.io/documentation/UjBaQsuvzdIHvE4D/getting-started) on our [prismic.io developer's portal](https://developers.prismic.io/).

#### Understand the Ruby development kit

You'll find more information about how to use the development kit included in this starter project, by reading [its README file](https://github.com/prismicio/ruby-kit/blob/master/README.md).

### Contribute to the starter project

Contribution is open to all developer levels, read our "[Contribute to the official kits](https://developers.prismic.io/documentation/UszOeAEAANUlwFpp/contribute-to-the-official-kits)" documentation to learn more.

### Licence

This software is licensed under the Apache 2 license, quoted below.

Copyright 2013 Zengularity (http://www.zengularity.com).

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this project except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
