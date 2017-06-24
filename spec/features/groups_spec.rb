require 'rails_helper'

RSpec.feature 'Groups' do
  let!(:user) { create(:user, email: 'user@user.com', first_name: 'Wanda', last_name: 'Maximoff') }

  scenario 'user can add a group' do
    login_as(user)
    visit root_path

    click_on 'Groups'
    click_on 'New group'

    click_on 'Create Group'
    expect(page).to have_content("can't be blank")

    fill_in 'group_name', with: 'Avengers Assemble!'
    click_on 'Create Group'

    expect(page).to have_content('New group')
    expect(page).to have_content('Avengers Assemble!')
  end

  scenario 'group owner can edit a group' do
    create(:group, name: 'Avengers Assemble!', owner_id: user.id)

    login_as(user)
    visit root_path

    click_on 'Groups'
    expect(page).to have_content('Avengers Assemble!')

    click_on 'Edit'
    fill_in 'group_name', with: 'Justice League!'
    click_on 'Update Group'

    expect(page).not_to have_content('Avengers Assemble!')
    expect(page).to have_content('Justice League!')
  end

  scenario 'member cannot edit group if he is not an owner' do
    group = create(:group, name: 'Avengers Assemble!')
    create(:membership, group: group, user: user)

    login_as(user)
    visit root_path

    click_on 'Groups'
    expect(page).to have_content('Avengers Assemble!')
    expect(page).not_to have_content('Edit')

    visit edit_group_path(group)
    expect(page).to have_content('You are not authorized to edit this group')
  end

  scenario 'not member cannot see a group' do
    group = create(:group, name: 'Avengers Assemble!')

    login_as(user)
    visit root_path

    click_on 'Groups'
    expect(page).not_to have_content('Avengers Assemble!')

    visit group_path(group)
    expect(page).to have_content('You are not authorized to see this group')
  end

  scenario 'owner can remove a group' do
    create(:group, name: 'Stark Industries', owner_id: user.id)

    login_as(user)
    visit root_path

    click_on 'Groups'
    click_on 'Delete'

    expect(page).to have_content('New group')
    expect(page).not_to have_content('Stark Industries')
  end

  scenario 'owner can add a friend to the group' do
    user1 = create(:user, email: 'user1@user.com', first_name: 'Pietro', last_name: 'Maximoff')

    create(:friendship, receiver_id: user.id, sender_id: user1.id)
    create(:group, name: 'Stark Industries', owner_id: user.id)

    login_as(user)
    visit root_path

    click_on 'Groups'
    click_on 'Edit'

    check 'Pietro Maximoff'

    click_on 'Update Group'
    click_on 'Show'

    expect(page).to have_content('Pietro Maximoff')
  end
end
