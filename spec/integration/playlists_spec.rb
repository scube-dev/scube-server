require 'spec_helper'

feature 'Playlists' do
  include UserIntegrationHelpers

  background do
    sign_in
  end

  scenario 'lists playlists' do
    Factory.create(:playlist, :name => 'Electro')
    Factory.create(:playlist, :name => 'Reggae')

    visit playlists_path

    page.body.should match(/Electro.+Reggae/m)
  end

  scenario 'creates playlist' do
    visit playlists_path

    click_link 'Create playlist'
    fill_in 'Name', :with => 'Electro'
    click_button 'Create'

    current_path.should == playlists_path
    page.should have_content('Electro')
  end

  scenario 'edits playlist' do
    Factory.create(:playlist, :name => 'Electro')
    visit playlists_path

    click_link 'Electro'
    fill_in 'Name', :with => 'Rock'
    click_button 'Save'

    current_path.should == playlists_path
    page.should have_content('Rock')
  end
end
