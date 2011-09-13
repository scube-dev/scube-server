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
      user.password_confirmation = user.password + 'INVALID'
    end

    it { should_not be_valid }
  end

  context 'when password_hash empty' do
    before do
      user.password_hash = ''
    end

    it { should_not be_valid }
  end

  context 'when a user with the same email address already exists' do
    it 'should not be valid' do
      user = Factory.create(:user, :email => 'unique@example.net')
      new_user = Factory.build(:user, :email => user.email)
      new_user.should_not be_valid
    end
  end

  describe '#password=' do
    it 'stores a bcrypt hash of the password in password_hash' do
      BCrypt::Password.new(user.password_hash).should == user.password
    end
  end

  describe '#authenticate?' do
    context 'with a valid password' do
      it 'returns true' do
        user.authenticate?(user.password).should be_true
      end
    end

    context 'with an invalid password' do
      it 'returns false' do
        user.authenticate?(user.password + '_INVALID').should be_false
      end
    end
  end
end
