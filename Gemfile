source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'rails-api', '~> 0.4'
gem 'pg'
gem 'bcrypt'
gem 'unicorn-rails'

gem 'has_secure_token'

gem 'rabl'


group :development do
  gem 'better_errors'
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'rspec'
  gem 'spork', github: 'tjouan/spork', branch: 'rspec-3'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', '~> 2.8'

  gem 'rb-kqueue',      require: false
  gem 'guard',          require: false
  gem 'guard-rspec',    require: false
  gem 'guard-spork',    require: false
end
