source 'http://rubygems.org'

gem 'rails', '~> 3.1'

gem 'pg', '~> 0.11'

gem 'haml', '~> 3.1'

gem 'bcrypt-ruby', '~> 3.0'

group :development, :test do
  gem 'rspec-rails', '~> 2.6'
  gem 'capybara', '~> 1.1'
  gem 'factory_girl_rails', '~> 1.2'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard', '~> 0.8'
  gem 'guard-rspec', '~> 0.4'
  gem 'guard-spork', '~> 0.2'
  if RbConfig::CONFIG['target_os'] =~ /linux/i
    gem 'rb-inotify', '~> 0.8'
  end
  gem 'shoulda-matchers', '~> 1.0'
end
