describe 'API sign in' do
  let(:user) { create :user }

  def do_create
    jpost api_sessions_path, session: {
      email:    user.email,
      password: user.password
    }
  end

  it 'returns a token' do
    do_create
    expect(json).to match(
      session: {
        id: an_instance_of(Fixnum),
        token: /\A[\w\d]{24}\z/
      }
    )
  end

  [:email, :password].each do |attr|
    context "with invalid #{attr}" do
      it 'rejects authentication' do
        allow(user).to receive(attr).and_return(user.send(attr) + '_INVALID')
        do_create
        expect(response).to be_not_found
        expect(response.body).to be_empty
      end
    end
  end
end
