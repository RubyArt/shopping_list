require 'rails_helper'

describe Friendship do
  describe '.for_user' do
    it 'returns users that are connected by friendship with the user' do
      user = create(:user)
      friend1 = create(:user)
      friend2 = create(:user)
      not_friend = create(:user)

      friendship1 = create(:friendship, sender: user, receiver: friend1)
      friendship2 = create(:friendship, sender: friend2, receiver: user)
      create(:friendship, sender: friend1, receiver: not_friend)

      expect(Friendship.for_user(user)).to eq([friendship1, friendship2])
    end
  end
end
