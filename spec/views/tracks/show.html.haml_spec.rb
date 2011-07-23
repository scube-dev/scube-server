require 'spec_helper'

describe 'tracks/show.html.haml' do
  let(:track) do
    mock_model('Track', :name => 'Mega song')
  end

  before do
    assign :track, track
  end

  it 'displays the name of the track' do
    render
    rendered.should have_selector('h1', :text => 'Mega song')
  end

  context 'audio tag' do
    it 'provides an audio stream for the track' do
      render
      rendered.should have_selector('audio[src]')
    end

    it 'provides controls' do
      render
      rendered.should have_selector('audio[controls]')
    end

    it 'has autoplay activated' do
      render
      rendered.should have_selector('audio[autoplay]')
    end

    it 'displays a text fallback for UA without support' do
      render
      rendered.should have_selector('audio',
        :text => 'Your browser does not support the audio element'
      )
    end
  end
end
