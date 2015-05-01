directories %w[app config spec]

guard :spork, rspec_env: { RAILS_ENV: 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/.+\.rb$})
end

guard :rspec, cmd: 'bundle exec rspec --drb -f doc' do
  watch(%r{^spec/.+_spec\.rb$})

  watch('config/routes.rb')           { 'spec' }
  watch('spec/spec_helper.rb')        { 'spec' }
  watch(%r{^spec/support/.+\.rb$})    { 'spec' }
  watch('spec/factories.rb')          { 'spec' }

  watch(%r{^app/(.+)\.rb$})           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})           { |m| "spec/lib/#{m[1]}_spec.rb" }

  watch('app/controllers/application_controller.rb')  { 'spec/controllers' }

  watch(%r{^app/views/})              { 'spec/features' }
  watch(%r{^app/views/layouts/})      { 'spec/integration' }

  watch(%r{^app/views/(.+)/(?:[^/]+).rabl}) do |m|
    "spec/controllers/#{m[1]}_controller_spec.rb"
  end
end
