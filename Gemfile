source 'https://rubygems.org'

ruby "2.3.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'momentjs-rails', :github => 'derekprior/momentjs-rails'
gem 'datetimepicker-rails', :git => 'git://github.com/zpaulovics/datetimepicker-rails.git', :branch => 'master', :submodules => true

# Use sqlite3 as the database for Active Record
gem 'pg'

gem 'tzinfo-data'

gem "omnicontacts", :git => 'git://github.com/Diego81/omnicontacts.git', :branch => 'master', :submodules => true

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
gem 'tether-rails'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'puma'
gem "font-awesome-rails"

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# To pass Rails variables to Javascript
gem 'gon'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'meta-tags'
gem 'textacular', require: 'textacular/rails'
gem 'to_xls-rails'
gem 'devise'
gem 'stripe'
gem 'razorpay'
gem 'rails_admin'
gem 'rollbar'
gem 'newrelic_rpm'
gem 'validates_timeliness'
gem 'simple_form'
gem "cocoon"
gem 'friendly_id'
gem 'acts-as-taggable-on'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem "capybara"
  gem "guard"
  gem "guard-livereload"
  gem "rack-livereload"
  gem "guard-rspec"
  gem "database_cleaner", :group => :test
  gem 'simplecov', :require => false, :group => :test
end

group :development do
  gem "bullet"
  gem 'brakeman', :require => false
end


# Use ActiveModel has_secure_password
#gem 'bcrypt', platforms: :ruby
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
# Use unicorn as the app server
gem 'rails_12factor', group: :production
gem 'yui-compressor', group: :production
#gem 'unicorn', group: :production

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
