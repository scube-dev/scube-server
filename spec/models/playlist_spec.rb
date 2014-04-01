require 'spec_helper'

describe Playlist do
  subject         { playlist }
  let(:playlist)  { FactoryGirl.build(:playlist) }

  it { should be_valid }
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :name }
  it { should_not allow_mass_assignment_of :user }
end
