require 'spec_helper'

feature 'API tracks' do
  include UserIntegrationHelpers

  background do
    api_sign_in
  end

  scenario 'lists tracks' do
    track_1 = Factory.create(:track_with_sound, :name => 'Track 1')
    track_2 = Factory.create(:track, :name => 'Track 2')

    get api_tracks_path, :format => :json

    response.body.should == [
      {
        :id => track_1.id,
        :name => 'Track 1',
        :sound_url => api_sound_url(track_1.sound)
      },
      {
        :id => track_2.id,
        :name => 'Track 2'
      }
    ].to_json
  end
end
