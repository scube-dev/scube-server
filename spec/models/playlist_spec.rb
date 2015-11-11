describe Playlist do
  subject(:playlist) { build :playlist }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :name }
end
