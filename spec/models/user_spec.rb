describe User do
  subject(:user) { FactoryGirl.build(:user) }

  it { should be_valid }
  it { should have_many :playlists }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_hash }

  context 'when a user with the same email address already exists' do
    let(:old_user)  { FactoryGirl.create(:user, email: 'unique@example.net') }
    subject(:user)  { FactoryGirl.build(:user, email: old_user.email) }

    it { should_not be_valid }

    it 'has an error on email attribute' do
      user.valid?
      expect(user.errors[:email].size).to eq 1
    end
  end

  context 'when password_confirmation does not match password' do
    before { user.password_confirmation = user.password + 'INVALID' }

    it { should_not be_valid }
  end

  describe '#password=' do
    it 'stores a bcrypt hash of the password in password_hash' do
      expect(BCrypt::Password.new(user.password_hash)).to eq user.password
    end
  end

  describe '#authenticate?' do
    context 'with a valid password' do
      it 'returns true' do
        expect(user.authenticate?(user.password)).to be true
      end
    end

    context 'with an invalid password' do
      it 'returns false' do
        expect(user.authenticate?(user.password + '_INVALID')).to be false
      end
    end
  end
end
