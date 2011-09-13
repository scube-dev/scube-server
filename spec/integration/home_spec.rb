require 'spec_helper'

feature 'Home page' do
  include UserIntegrationHelpers

  background do
    sign_in
  end

  scenario 'displays playlists' do
    playlist = Factory.create(:playlist, :name => 'Electro')

    visit root_path

    page.should have_content('Electro')
  end

  scenario 'displays last track added' do
    Factory.create(:track,
      :name       => 'Mega song 1',
      :created_at => '2011-07-27 19:13:42'
    )
    Factory.create(:track,
      :name       => 'Mega song 2',
      :created_at => '2011-07-27 19:58:57'
    )

    visit root_path

    page.body.should match(/Mega song 2.+Mega song 1/m)
  end
end
