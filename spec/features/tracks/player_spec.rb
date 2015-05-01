feature 'Tracks player' do
  include UserIntegrationHelpers

  background { sign_in }

  scenario 'includes a player in track page' do
    track = FactoryGirl.create(:track_with_sound)

    visit track_path(track)

    expect(page).to have_xpath "//audio[@src='#{sound_path track.sound}']"
    visit find('audio')[:src]
  end
end
