source 'https://rubygems.org'

%w[
  actionpack
  actionview
  activemodel
  activerecord
  activesupport
  railties
].each do |gem_name|
  gem gem_name, '4.2.10'
end
gem 'rails-api', '0.4.1'

gem 'pg', '~> 0.18'
gem 'bcrypt'
gem 'unicorn-rails'

gem 'has_secure_token'

gem 'rabl'

gem 'bootsnap', require: false


group :development do
  gem 'better_errors'
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'rspec'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'

  gem 'rb-kqueue', require: false
  gem 'guard', require: false
  gem 'guard-rspec', require: false
end
