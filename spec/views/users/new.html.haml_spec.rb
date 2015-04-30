describe 'users/new' do
  let(:user) { mock_model(User).as_new_record.as_null_object }

  before { assign :user, user }

  it 'renders a form to sign up' do
    render
    expect(rendered)
      .to have_selector "form[method=post][action='#{users_path}']"
    expect(rendered).to have_selector 'input[type=submit]'
  end

  it 'renders a text field with a label for the mail address' do
    render
    expect(rendered).to have_selector "input[type=text][name='user[email]']"
    expect(rendered).to have_selector 'label[for=user_email]', text: 'Email'
  end

  it 'renders a password field with a label for the password' do
    render
    expect(rendered)
      .to have_selector "input[type=password][name='user[password]']"
    expect(rendered)
      .to have_selector 'label[for=user_password]', text: 'Password'
  end

  it 'renders a password field with a label for the password confirmation' do
    render
    expect(rendered)
      .to have_selector "input[type=password][name='user[password_confirmation]']"
    expect(rendered).to have_selector(
      'label[for=user_password_confirmation]',
      text: 'Password confirmation'
    )
  end

  context 'when the user has some validation errors' do
    it 'on the email address uniqueness' do
      user = FactoryGirl.create(:user, email: 'unique@example.net')
      new_user = FactoryGirl.build(:user, email: user.email)
      new_user.save
      assign :user, new_user
      render
      expect(rendered).to have_content 'Email has already been taken'
    end
  end
end
