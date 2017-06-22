require 'rails_helper'

RSpec.feature 'Sign up' do
  let!(:user) { create(:user, email: 'user@user.com') }

  scenario 'user can sign up' do
    visit root_path

    click_on 'Sign up'
    expect(page).to have_content 'Register'

    fill_in 'user_email', with: 'user@user.com'
    fill_in 'user_password', with: 'secret12'
    fill_in 'user_password_confirmation', with: 'secret12'

    within('.content') { expect { click_on 'Sign up' }.not_to change { User.count } }
    expect(page).to have_content "can't be blank"
    expect(page).to have_content 'has already been taken'

    fill_in 'user_email', with: 'new_user@user.com'
    fill_in 'user_password', with: 'secret12'
    fill_in 'user_password_confirmation', with: 'error'

    within('.content') { expect { click_on 'Sign up' }.not_to change { User.count } }
    expect(page).to have_content "doesn't match Password"

    fill_in 'user_first_name', with: 'Steve'
    fill_in 'user_last_name', with: 'Rogers'
    fill_in 'user_password', with: 'secret12'
    fill_in 'user_password_confirmation', with: 'secret12'

    within('.content') { expect { click_on 'Sign up' }.to change { User.count }.by 1 }
    expect(page).to have_content 'Welcome! You have signed up successfully.'

    expect(page).to have_current_path(root_path)
  end
end
