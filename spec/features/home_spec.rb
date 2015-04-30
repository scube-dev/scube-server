feature 'Home page' do
  include UserIntegrationHelpers

  background { sign_in }

  scenario 'displays playlists' do
    FactoryGirl.create(:playlist, name: 'Electro')

    visit root_path

    expect(page).to have_content 'Electro'
  end

  scenario 'displays last track added' do
    FactoryGirl.create(:track,
      name:       'Mega song 1',
      created_at: '2011-07-27 19:13:42'
    )
    FactoryGirl.create(:track,
      name:       'Mega song 2',
      created_at: '2011-07-27 19:58:57'
    )

    visit root_path

    expect(page.body).to match /Mega song 2.+Mega song 1/m
  end
end
