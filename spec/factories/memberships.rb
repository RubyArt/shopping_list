FactoryGirl.define do
  factory :membership do
    user_id { create(:user).id }
    group_id { create(:group).id }
  end
end
