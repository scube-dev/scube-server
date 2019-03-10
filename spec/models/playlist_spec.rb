RSpec.describe Playlist do
  subject(:playlist) { build :playlist }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :name }
end
