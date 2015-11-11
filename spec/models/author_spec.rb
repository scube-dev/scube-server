describe Author do
  subject(:author) { build :author }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
