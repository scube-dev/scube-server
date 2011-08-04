require 'spec_helper'

describe 'sessions/new.html.haml' do
  it 'renders a form to sign in' do
    render
    rendered.should \
      have_selector("form[method=post][action='#{sessions_path}']")
    rendered.should have_selector('input[type=submit]')
  end

  it 'renders a text field with a label for the mail address' do
    render
    rendered.should \
      have_selector("input[type=text][name='session[email]']")
    rendered.should \
      have_selector('label[for=session_email]', :text => 'Email')
  end

  it 'renders a password field with a label for the password' do
    render
    rendered.should \
      have_selector("input[type=password][name='session[password]']")
    rendered.should \
      have_selector('label[for=session_password]', :text => 'Password')
  end
end
