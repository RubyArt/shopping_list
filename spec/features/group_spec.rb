require 'rails_helper'

RSpec.feature 'Sign in' do
  let!(:user) { create(:user, email: 'user@user.com') }

  scenario 'user can log in and log out' do
    login_as(user)
    visit root_path

    click_on 'Groups'
  end
end
