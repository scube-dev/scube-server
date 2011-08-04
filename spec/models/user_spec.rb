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
