require 'rails_helper'

RSpec.feature 'Tasks' do
  let!(:user) { create(:user, email: 'user@user.com', first_name: 'Wanda', last_name: 'Maximoff') }
  let!(:user2) { create(:user, email: 'user2@user.com', first_name: 'Pietro', last_name: 'Maximoff') }
  let!(:group) { create(:group, name: 'Family', owner_id: user.id) }

  scenario 'group member can add a task' do
    create(:membership, group_id: group.id, user_id: user2.id)

    login_as(user)
    visit root_path

    click_on 'Groups'
    click_on 'Show'

    expect(page).to have_content('Wanda Maximoff')
    expect(page).to have_content('Pietro Maximoff')

    click_on 'Add Task'

    click_on 'Create Task'
    expect(page).to have_content("can't be blank")

    fill_in 'task_name', with: 'save people'
    fill_in 'task_description', with: 'place: Sokovia'
    select 'Pietro Maximoff', from: 'task_owner_id'

    click_on 'Create Task'
    expect(page).to have_content('save people')
    expect(page).to have_content('place: Sokovia')
    expect(page).to have_content('Pietro Maximoff')
  end

  scenario 'group member can edit a task' do
    create(:membership, group_id: group.id, user_id: user2.id)
    create(:task, name: 'save people', group_id: group.id, description: 'Sokovia')

    login_as(user2)
    visit root_path

    click_on 'Groups'
    click_on 'Show'

    expect(page).to have_content("Family group's tasks")
    click_on 'Edit'

    fill_in 'task_description', with: 'New York'
    check 'Completed'
    click_on 'Update Task'

    expect(page).to have_content('New York')
    expect(page).to have_content('true')
  end

  scenario 'user who is not a group member cannot create a task' do
    login_as(user2)
    visit new_group_task_path(group)

    expect(page).to have_content('You are not authorized to create/edit task for this group')
  end

  scenario 'user who is not a group member cannot edit a task' do
    task = create(:task, name: 'save people', group_id: group.id, description: 'the Earth')
    login_as(user2)
    visit edit_group_task_path(group, task)

    expect(page).to have_content('You are not authorized to create/edit task for this group')
  end
end
