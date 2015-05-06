describe Key do
  subject(:key) { build :key }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :name }

  it 'has a token when created' do
    key.save
    expect(key.token).to match /\A[\w\d]{24,}\z/
  end
end
