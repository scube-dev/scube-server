require 'spec_helper'

describe User do
  subject { user }
  let(:user) { Factory.build(:user) }

  context 'with valid attributes' do
    it { should be_valid }
  end

  context 'when email empty' do
    before do
      user.email = ''
    end

    it { should_not be_valid }
  end

  context 'when password empty' do
    before do
      user.password = ''
    end

    it { should_not be_valid }
  end

  context 'when password_confirmation does not match password' do
    before do
      user.password_confirmation = 'WRONG'
    end

    it { should_not be_valid }
  end

  describe '#hash_password' do
    it 'is received when #save is sent' do
      user.should_receive(:hash_password)
      user.save
    end

    it 'stores a bcrypt hash of the password' do
      user.save
      BCrypt::Password.new(user.password_hash).should == user.password
    end
  end

  describe '.authenticate' do
    let (:user) { Factory.create(:user) }

    it 'returns the user with valid credentials' do
      User.authenticate(
        user.email,
        user.password
      ).should == user
    end

    it 'returns false with invalid credentials' do
      User.authenticate(
        user.email,
        'WRONG'
      ).should be_false
    end
  end
end
