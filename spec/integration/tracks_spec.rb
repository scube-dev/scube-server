require 'spec_helper'

feature 'Tracks' do
  include UserIntegrationHelpers

  background do
    sign_in
  end

  scenario 'shows track' do
    track = Factory.create(:track, :name => 'Mega song')

    visit track_path(track)

    page.should have_content('Mega song')
  end

  scenario 'creates track' do
    visit root_path

    click_link 'Add a track'
    fill_in 'Name', :with => 'Mega song'
    attach_file 'File', File.expand_path('spec/fixtures/test.mp3')
    click_button 'Upload'

    current_path.should == track_path(Track.find(:first))
    page.should have_content('Mega song')
  end

  scenario 'plays track' do
    track = Factory.create(:track_with_sound)

    visit track_path(track)

    page.should have_xpath "//audio[@src='#{sound_path(track.sound)}']"
    visit find('audio')[:src]
  end

  after do
    `rm -f #{Rails.root}/data/sounds/*`
  end
end
