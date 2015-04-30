describe 'tracks/show' do
  let(:track) { FactoryGirl.create(:track) }

  before { assign :track, track }

  it 'displays the name of the track' do
    render
    expect(rendered).to have_selector 'h1', text: 'Mega song'
  end

  context 'when track has a sound' do
    let(:track) { FactoryGirl.create(:track_with_sound) }

    it 'provides an audio stream for the track' do
      render
      expect(rendered).to have_selector 'audio[src]'
    end

    it 'provides controls' do
      render
      expect(rendered).to have_selector 'audio[controls]'
    end

    it 'has autoplay activated' do
      render
      expect(rendered).to have_selector 'audio[autoplay]'
    end

    it 'displays a text fallback for UA without support' do
      render
      expect(rendered).to have_selector(
        'audio',
        text: 'Your browser does not support the audio element'
      )
    end
  end
end
