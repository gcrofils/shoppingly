#source 'https://rubygems.org'
source 'https://ruby.taobao.org'

ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# views
gem 'haml'
gem 'growlyflash'

# bootstrap
gem "therubyracer"
gem "less-rails"
gem "twitter-bootstrap-rails"
#gem 'formtastic'
gem 'formtastic-bootstrap'
#gem "cocoon" # Dynamic nested forms using jQuery made easy

# step-by-step wizard controllers
gem 'wicked'

# state machine
gem 'workflow'

# A set of responders modules to dry up your Rails 4.2+ app.
gem 'responders'

# Flexible authentication solution for Rails with Warden. 
gem 'devise'

# A library for generating fake data such as names, addresses, and phone numbers.
gem 'faker'

# Seed Rails application by convention, not configuration.
gem 'sprig'

# The administration framework for Ruby on Rails applications. http://activeadmin.info
gem 'activeadmin', '~> 1.0.0.pre1'
# Plus integrations with:
gem 'cancancan'
# gem 'draper'
# gem 'pundit' #Minimal authorization through OO design and pure Ruby classes


# A Ruby gem for on-the-fly processing 
gem 'dragonfly'
gem 'dragonfly-s3_data_store'

# A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts.
gem 'acts-as-taggable-on', '~> 3.4'

# Complete Ruby geocoding solution.
gem 'geocoder'

# Google Maps
gem 'gmaps4rails'

# Ckeditor integration gem for rails
gem 'ckeditor'

# Dead-Simple Vote and Karma Management
gem 'thumbs_up', github: 'bouchard/thumbs_up'

# slugging and permalink plugins for ActiveRecord.
gem 'friendly_id', '~> 5.1.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  # dry_crud generates simple and extendable controllers, views and helpers that support you to DRY up the CRUD code in your Rails projects.
  gem 'dry_crud'
  
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  
  #shotgun config.ru
  gem 'shotgun'  
  
  # html2haml
  gem 'html2haml'
  
  # guard
  gem 'guard'
  gem 'guard-livereload', '~> 2.4', require: false
  gem "rack-livereload"
  
end

group :production do
  # Use PostgreSQL as the database for Active Record
  gem 'pg'
  
  # Rack::Cache is suitable as a quick drop-in component to enable HTTP caching for Rack-based applications that produce freshness (Expires, Cache-Control) and/or validation (Last-Modified, ETag) information.
  gem 'rack-cache', :require => 'rack/cache'
  
end


group :heroku do 
  # This gem replaces the need for the plugins, and ensures that Rails 4 is optimally configured for executing on Heroku.
  gem 'rails_12factor'
  
  # Puma Webserver
  gem 'puma'
  
  # https://github.com/heroku/rack-timeout
  gem "rack-timeout"
end


