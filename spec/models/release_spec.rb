RSpec.describe Release do
  subject(:release) { build :release }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_numericality_of(:year).only_integer }
end
