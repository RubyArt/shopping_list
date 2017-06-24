require 'rails_helper'

RSpec.feature 'Sign up' do
  let!(:user) { create(:user, email: 'user@user.com') }
  let!(:group) { create(:group, owner: user) }

  scenario 'user can see uncompleted tasks' do
    task = create(:task, group: group, name: 'Learn Mortal Kombat X')

    login_as(user)
    visit root_path

    click_on 'To Do 1'

    within('#uncompleted_tasks') do
      expect(page).to have_content('Learn Mortal Kombat X')
    end

    page.find("#task_checkbox_#{task.id}").click
  end

  scenario 'user can see completed tasks' do
    create(:task, :completed, group: group, name: 'Learn Mortal Kombat X')

    login_as(user)
    visit root_path

    click_on 'To Do 0'

    within('#completed_tasks') do
      expect(page).to have_content('Learn Mortal Kombat X')
    end
  end
end
