source 'http://rubygems.org'

gem 'rails',  '~> 3.1'
gem 'pg',     '~> 0.17'
gem 'haml',   '~> 4.0'
gem 'bcrypt', '~> 3.0'
gem 'rabl',   '~> 0.6'

group :development, :test do
  gem 'rspec-rails',        '~> 2.6'
  gem 'capybara',           '~> 1.1'
  gem 'factory_girl_rails', '~> 1.2'
  gem 'shoulda-matchers',   '~> 1.0'
end

eval File.read('Gemfile-custom.rb') if File.exist?('Gemfile-custom.rb')
