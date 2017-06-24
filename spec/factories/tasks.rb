FactoryGirl.define do
  factory :task do
    sequence(:name) { |n| "awesome_task_#{n}" }
    sequence(:description) { |n| "interesting_but_scary_#{n}" }
    group_id { create(:group).id }
    creator_id { create(:user).id }
    owner_id { create(:user).id }
    completed false

    trait :completed do
      completed true
      completed_at { Time.current }
    end
  end
end
