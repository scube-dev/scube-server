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

  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end
