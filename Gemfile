source 'https://rubygems.org'

gem 'rails',  '~> 4.2.1'
gem 'pg'
gem 'bcrypt'
gem 'unicorn-rails'

gem 'haml'
gem 'rabl'

gem 'uglifier'
gem 'jquery-rails'


group :development, :test do
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'

  gem 'spork', github: 'tjouan/spork', branch: 'rspec-3'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'

  gem 'rb-kqueue',      require: false
  gem 'guard',          require: false
  gem 'guard-rspec',    require: false
  gem 'guard-spork',    require: false
end
