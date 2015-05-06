describe 'API sign in' do
  let(:user) { create :user }

  def do_create
    jpost :sessions, session: {
      email:    user.email,
      password: user.password
    }
  end

  it 'signs the user in with valid credentials' do
    do_create
    expect(json).to eq(user: { id: user.id })
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
