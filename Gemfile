source 'https://rubygems.org'

gem 'rails',  '~> 4.2.1'
gem 'pg',     '~> 0.17'
gem 'haml',   '~> 4.0'
gem 'bcrypt', '~> 3.0'
gem 'rabl',   '~> 0.6'

group :development, :test do
  gem 'rspec-rails',        '~> 2.6'
  gem 'spork',              '~> 1.0rc'
  gem 'capybara',           '~> 2.2'
  gem 'factory_girl_rails', '~> 4.4'
  gem 'shoulda-matchers',   '~> 2.5'
end

eval File.read('Gemfile-custom.rb') if File.exist?('Gemfile-custom.rb')
