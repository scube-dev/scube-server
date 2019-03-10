source 'https://rubygems.org'

%w[
  actionpack
  actionview
  activemodel
  activerecord
  activesupport
  railties
].each do |gem_name|
  gem gem_name, '~> 5.0.7'
end

gem 'bcrypt', '~> 3.1'
gem 'bootsnap', '~> 1.4', require: false
gem 'pg', '~> 0.21'
gem 'rabl', '~> 0.14'
gem 'unicorn-rails', '~> 2.2'


group :development do
  gem 'better_errors', '~> 2.5'
end

group :development, :test do
  gem 'pry-rails', '~> 0.3'
  gem 'rspec-rails', '~> 3.8'
end

group :test do
  gem 'factory_bot_rails', '~> 5.0'
  gem 'rspec', '~> 3.8'
  gem 'shoulda-matchers', '~> 4.0'
end
