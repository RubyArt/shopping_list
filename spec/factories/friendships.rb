FactoryGirl.define do
  factory :friendship do
    sender_id { create(:user).id }
    receiver_id { create(:user).id }
  end
end
