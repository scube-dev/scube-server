Given /^a playlist named "([^"]*)"$/ do |name|
  Factory.create(:playlist, :name => name)
end
