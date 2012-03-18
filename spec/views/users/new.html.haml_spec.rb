require 'spec_helper'

describe 'users/new' do
  let(:user) do
    mock_model(User).as_new_record.as_null_object
  end

  before do
    assign :user, user
  end

  it 'renders a form to sign up' do
    render
    rendered.should have_selector("form[method=post][action='#{users_path}']")
    rendered.should have_selector('input[type=submit]')
  end

  it 'renders a text field with a label for the mail address' do
    render
    rendered.should have_selector(
      "input[type=text][name='user[email]']"
    )
    rendered.should have_selector(
      'label[for=user_email]', :text => 'Email'
    )
  end

  it 'renders a password field with a label for the password' do
    render
    rendered.should have_selector(
      "input[type=password][name='user[password]']"
    )
    rendered.should have_selector(
      'label[for=user_password]', :text => 'Password'
    )
  end

  it 'renders a password field with a label for the password confirmation' do
    render
    rendered.should have_selector(
      "input[type=password][name='user[password_confirmation]']"
    )
    rendered.should have_selector(
      'label[for=user_password_confirmation]',
      :text => 'Password confirmation'
    )
  end

  context 'when the user has some validation errors' do
    it 'on the email address uniqueness' do
      user = Factory.create(:user, :email => 'unique@example.net')
      new_user = Factory.build(:user, :email => user.email)
      new_user.save
      assign :user, new_user
      render
      rendered.should have_content 'Email has already been taken'
    end
  end
end
