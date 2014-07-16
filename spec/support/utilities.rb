include ApplicationHelper

RSpec::Matchers.define :have_correct_page do |title|
  match do |page|
    expect(page).to have_selector('h1', text: title)
    expect(page).to have_title(full_title(title))
  end
end


def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text:message)
  end
end


RSpec::Matchers.define :have_user_menu do
  match do |page|
    expect(page).not_to have_link('Sign in',  href: signin_path)
    expect(page).to have_link(    'Profile',  href: user_path(user))
    expect(page).to have_link(    'Sign out', href: signout_path)
    expect(page).to have_link(    'Settings')
  end
end
