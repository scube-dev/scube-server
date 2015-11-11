describe User do
  subject(:user) { build :user }

  it { is_expected.to be_valid }

  it { is_expected.to have_many :playlists }

  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to validate_length_of(:password).is_at_least 8 }

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
