source 'http://rubygems.org'

gem 'rails',  '~> 4.0'
gem 'pg',     '~> 0.17'
gem 'haml',   '~> 4.0'
gem 'bcrypt', '~> 3.0'
gem 'rabl',   '~> 0.6'

gem 'protected_attributes', '~> 1.0'

group :development, :test do
  gem 'rspec-rails',        '~> 2.6'
  gem 'capybara',           '~> 2.2'
  gem 'factory_girl_rails', '~> 4.4'
  gem 'shoulda-matchers',   '~> 2.5'
end

eval File.read('Gemfile-custom.rb') if File.exist?('Gemfile-custom.rb')
