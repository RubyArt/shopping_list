require 'rails_helper'

RSpec.feature 'Friends' do
  let!(:user) { create(:user, email: 'user@user.com', first_name: 'Wanda', last_name: 'Maximoff') }
  let!(:user2) { create(:user, email: 'user2@user.com', first_name: 'Pietro', last_name: 'Maximoff') }

  scenario 'user can add a friend' do
    login_as(user)
    visit root_path

    click_on 'Friends'
    click_on 'Add friend'

    expect(page).to have_content('Invite a friend')

    click_on 'Send invitation'
    expect(page).to have_content('Friends')

    click_on 'Add friend'
    expect(page).not_to have_content('Pietro Maximoff')
  end

  scenario 'user cannot add a friend again' do
    create(:friendship, receiver_id: user2.id, sender_id: user.id)

    login_as(user)
    visit root_path

    click_on 'Friends'
    click_on 'Add friend'

    expect(page).to have_content('Invite a friend')
    expect(page).not_to have_content('Pietro Maximoff')
  end

  scenario 'user cannot add a friend when already sent an invitation to him' do
    create(:invitation, receiver_id: user.id, sender_id: user2.id)

    login_as(user)
    visit root_path

    click_on 'Friends'
    click_on 'Add friend'

    expect(page).to have_content('Invite a friend')
    expect(page).not_to have_content('Pietro Maximoff')
  end

  scenario 'user cannot add a friend who already sent an invitation to him' do
    create(:invitation, receiver_id: user2.id, sender_id: user.id)

    login_as(user2)
    visit root_path

    click_on 'Friends'
    click_on 'Add friend'

    expect(page).to have_content('Invite a friend')
    expect(page).not_to have_content('Wanda Maximoff')
  end
end
