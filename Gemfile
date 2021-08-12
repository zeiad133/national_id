# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.3'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'puma', '~> 4.1'
gem 'rack-cors', require: 'rack/cors'
gem 'bootsnap', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '0.63'
  gem 'rubocop-rspec'
end

group :development, :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# active model serliazers gem to serialize model objects into json
# gem 'active_model_serializers', '~> 0.10.0'
# Seamless JWT authentication for Rails API
gem 'rswag-api'
gem 'rswag-ui'
gem 'dotenv-rails'
gem 'lograge'
