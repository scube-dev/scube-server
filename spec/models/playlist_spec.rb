describe Playlist do
  subject         { playlist }
  let(:playlist)  { FactoryGirl.build(:playlist) }

  it { should be_valid }
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :name }
end
