ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir['spec/support/**/*.rb'].map { |e| require e.gsub 'spec/', '' }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true

  config.include FactoryBot::Syntax::Methods
  config.include AcceptanceHelpers, type: :feature
  config.include AcceptanceHelpers, type: :request

  config.after :all do
    `rm -f #{Rails.configuration.sounds_path}/*`
  end
end
