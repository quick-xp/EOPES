source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
gem 'execjs'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#検索画面用
gem 'ransack'
#認証
gem "omniauth-oauth2"
gem "omniauth-eveonline"
gem 'devise'
#AdminLTE
gem 'adminlte-rails'
#DataTables
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
#環境設定
gem 'dotenv-rails'
#session
gem 'activerecord-session_store'
#rest client
gem "rest-client"
#bulk insert
gem "activerecord-import"

#cron
gem 'whenever', :require => false

group :production do
  gem "unicorn"
end

group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
  #Debugger
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug' #ruby 2.0
  gem 'annotate'
end

group :test do
  gem "faker"
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem "timecop"
  gem 'simplecov', :require => false
  gem 'capybara-webkit'
  gem 'turnip'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
