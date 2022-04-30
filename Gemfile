source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# 회원가입 및 로그인 관련
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise-i18n', '~> 1.10', '>= 1.10.2'
gem 'omniauth-oauth2' # omniauth
gem 'omniauth-naver' # omniauth naver
gem 'omniauth-kakao', git: "https://github.com/hoonpark7442/omniauth-kakao"
# gem 'omniauth-kakao', git: "https://github.com/DevStarSJ/omniauth-kakao"

# global settings
gem 'rails-settings-cached', '~> 2.8', '>= 2.8.2'
gem 'request_store', '~> 1.5', '>= 1.5.1' # RequestStore gives you per-request global storage

# inline_svg
gem 'inline_svg', '~> 1.8' # Embed SVG documents in your Rails views and style them with CSS

gem 'sprockets', '~> 4.0'

# markdown
gem 'redcarpet', '~> 3.5' # A fast, safe and extensible Markdown to (X)HTML parser
gem 'front_matter_parser', '~> 1.0', '>= 1.0.1' # Parse a front matter from syntactically correct strings or files
gem 'rouge', '~> 3.28' # A pure-ruby code highlighter

# # html parser
# gem 'nokogiri', '~> 1.13', '>= 1.13.4' # HTML, XML, SAX, and Reader parser

# tag
gem 'acts-as-taggable-on', '~> 9.0', '>= 9.0.1' # A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts

# slug generator
gem 'sterile', '~> 1.0', '>= 1.0.23' # Transliterate Unicode and Latin1 text to 7-bit ASCII for URLs

# use counter_culture instead of counter_cache
gem 'counter_culture', '~> 0.1.33' # counter_culture provides turbo-charged counter caches that are kept up-to-date

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.1', '>= 5.1.1'
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'

  gem 'bullet', '~> 7.0', '>= 7.0.1'

  gem 'pry', '~> 0.14.1'

  gem 'faker', '~> 2.20'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'shoulda-matchers', '~> 5.1', require: false # Simple one-liner tests for common Rails functionality
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
