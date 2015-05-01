require 'spork'

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
    config.infer_spec_type_from_file_location!
    config.use_transactional_fixtures = true
    config.after(:all) do
      `rm -f #{Rails.configuration.sounds_path}/*`
    end
  end
end

Spork.each_run do
  Rails.application.reload_routes!
  FactoryGirl.reload
end
