require 'rails_helper'

RSpec.feature 'Invitations' do
  let!(:user) { create(:user, email: 'user@user.com', first_name: 'Wanda', last_name: 'Maximoff') }
  let!(:user2) { create(:user, email: 'user2@user.com', first_name: 'Pietro', last_name: 'Maximoff') }

  scenario 'user can see received invitation' do
    create(:invitation, receiver_id: user2.id, sender_id: user.id)

    login_as(user2)
    visit root_path

    click_on 'Invitations'
    expect(page).to have_content('Wanda Maximoff')
    expect(page).to have_content('Accept')
    expect(page).to have_content('Decline')
  end

  scenario 'user can see sent invitation' do
    create(:invitation, receiver_id: user2.id, sender_id: user.id)

    login_as(user)
    visit root_path
    click_on 'Invitations'
    expect(page).to have_content('Pietro Maximoff')
    expect(page).not_to have_content('Accept')
    expect(page).not_to have_content('Decline')
  end

  scenario 'user can accept an invitation' do
    create(:invitation, receiver_id: user2.id, sender_id: user.id)

    login_as(user2)
    visit root_path

    expect(page).to have_content('Invitations 1')

    click_on 'Invitations'
    expect(page).to have_content('Wanda Maximoff')

    click_on 'Accept'
    expect(page).not_to have_content('Wanda Maximoff')

    click_on 'Friends'
    expect(page).to have_content('Wanda Maximoff')
  end

  scenario 'user can decline an invitation' do
    create(:invitation, receiver_id: user2.id, sender_id: user.id)

    login_as(user2)
    visit root_path

    click_on 'Invitations'
    expect(page).to have_content('Wanda Maximoff')

    click_on 'Decline'
    expect(page).not_to have_content('Wanda Maximoff')

    click_on 'Friends'
    expect(page).not_to have_content('Wanda Maximoff')
  end
end
