RSpec.describe Key do
  subject(:key) { build :key }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :token }

  it 'has a token when created' do
    key.save
    expect(key.token).to match /\A[\w\d]{24,}\z/
  end

  describe '.authenticate' do
    context 'when given token belong to existing key' do
      before { key.save }

      it 'returns the key' do
        expect(described_class.authenticate key.token).to eq key
      end
    end

    context 'when given token is unknown' do
      it 'returns nil' do
        expect(described_class.authenticate key.token).to be nil
      end
    end
  end
end
