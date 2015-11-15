RSpec.describe 'API sign in' do
  let(:user)      { create :user }
  let(:email)     { user.email }
  let(:password)  { user.password }

  def do_create
    jpost api_sessions_path, session: {
      email:    email,
      password: password
    }
  end

  before { do_create }

  it 'returns a token' do
    expect(json).to match(
      session: {
        id:     an_instance_of(Fixnum),
        token:  /\A[\w\d]{24}\z/
      }
    )
  end

  [:email, :password].each do |attr|
    context "with invalid #{attr}" do
      let(attr) { 'INVALID' }

      it 'rejects authentication' do
        expect(response).to be_not_found
        expect(response.body).to be_empty
      end
    end
  end
end
