RSpec.describe ReleaseTrack do
  subject(:release_track) { build :release_track }

  it { is_expected.to be_valid }

  specify do
    is_expected
      .to validate_numericality_of(:number)
      .only_integer
      .is_greater_than 0
  end
end
