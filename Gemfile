source 'https://rubygems.org'

gem 'rails',  '~> 4.2.1'
gem 'pg',     '~> 0.17'
gem 'bcrypt', '~> 3.0'
gem 'unicorn-rails'

gem 'haml',   '~> 4.0'
gem 'rabl',   '~> 0.6'


group :development, :test do
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails',        '~> 2.6'
  gem 'rspec-activemodel-mocks'
  gem 'spork',              github: 'tjouan/spork', branch: 'rspec-3'
  gem 'capybara',           '~> 2.2'
  gem 'factory_girl_rails', '~> 4.4'
  gem 'shoulda-matchers',   '~> 2.5'

  gem 'rb-kqueue',      require: false
  gem 'guard',          require: false
  gem 'guard-rspec',    require: false
  gem 'guard-spork',    require: false
end
