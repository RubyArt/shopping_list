require 'rails_helper'

RSpec.feature 'Sign in' do
  let!(:user) { create(:user, email: 'user@user.com') }

  scenario 'user can log in and log out' do
    visit root_path
    click_on 'Sign in'

    fill_in 'user_email', with: 'new_employee@daijob.com'
    fill_in 'user_password', with: 'error'
    within('.content') { click_on 'Log in' }

    expect(page).to have_content 'Invalid Email or password.'

    fill_in 'user_email', with: 'user@user.com'
    fill_in 'user_password', with: 'secret12'
    within('.content') { click_on 'Log in' }

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path root_path

    click_on 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_current_path root_path
  end
end
