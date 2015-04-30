describe 'sessions/new' do
  it 'renders a form to sign in' do
    render
    expect(rendered)
      .to have_selector "form[method=post][action='#{sessions_path}']"
    expect(rendered).to have_selector 'input[type=submit]'
  end

  it 'renders a text field with a label for the mail address' do
    render
    expect(rendered).to have_selector("input[type=text][name='session[email]']")
    expect(rendered).to have_selector('label[for=session_email]', text: 'Email')
  end

  it 'renders a password field with a label for the password' do
    render
    expect(rendered)
      .to have_selector "input[type=password][name='session[password]']"
    expect(rendered)
      .to have_selector 'label[for=session_password]', text: 'Password'
  end

  it 'renders a link to the sign in page' do
    render
    expect(rendered)
      .to have_selector "a[href='#{new_user_path}']", text: 'Sign up'
  end
end
