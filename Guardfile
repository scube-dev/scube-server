guard 'spork', :cucumber => false, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/routes.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/.+\.rb$})
end

guard 'rspec', :cli => '--drb', :notification => false do
  watch(%r{^spec/.+_spec\.rb$})

  watch('spec/spec_helper.rb')        { 'spec' }
  watch(%r{^spec/support/.+\.rb$})    { 'spec' }
  watch('spec/factories.rb')          { 'spec' }

  watch(%r{^app/(.+)\.rb$})           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.haml$})         { |m| "spec/#{m[1]}.haml_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})           { |m| "spec/lib/#{m[1]}_spec.rb" }

  watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
end