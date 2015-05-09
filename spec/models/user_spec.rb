describe User do
  subject(:user) { build :user }

  it { is_expected.to be_valid }
  it { is_expected.to have_many :playlists }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least 8 }

  context 'when a user with the same email address already exists' do
    let(:old_user)  { create :user, email: 'unique@example.net' }
    subject(:user)  { build :user, email: old_user.email }

    it { is_expected.not_to be_valid }

    it 'has an error on email attribute' do
      user.valid?
      expect(user.errors[:email].size).to eq 1
    end
  end

  describe '#authenticate?' do
    context 'with a valid password' do
      it 'returns true' do
        expect(user.authenticate? user.password).to be true
      end
    end

    context 'with an invalid password' do
      it 'returns false' do
        expect(user.authenticate? user.password + '_INVALID').to be false
      end
    end
  end
end
