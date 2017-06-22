FactoryGirl.define do
  factory :invitation do
    sender_id { create(:user).id }
    receiver_id { create(:user).id }

    trait :accepted do
      accepted_at { Time.current }
    end

    trait :rejected do
      rejected_at { Time.current }
    end
  end
end
