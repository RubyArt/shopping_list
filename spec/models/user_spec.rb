require 'rails_helper'

describe User do
  describe '#to_s' do
    it 'returns first_name and last_name' do
      user = create(:user, first_name: 'Steve', last_name: 'Rogers')
      expect(user.to_s).to eq('Steve Rogers')
    end
  end

  describe '#friends' do
    it 'returns users that have friendship whit the user' do
      user = create(:user)
      friend1 = create(:user)
      friend2 = create(:user)
      not_friend = create(:user)

      create(:friendship, sender: user, receiver: friend1)
      create(:friendship, sender: friend2, receiver: user)
      create(:friendship, sender: friend1, receiver: not_friend)

      expect(user.friends).to eq([friend1, friend2])
    end
  end

  describe '#not_friedns' do
    it 'returns users that do not have friendship whit the user' do
      user = create(:user)
      friend1 = create(:user)
      friend2 = create(:user)
      invited_not_friend1 = create(:user)
      invited_not_friend2 = create(:user)
      not_friend = create(:user)

      create(:friendship, sender: user, receiver: friend1)
      create(:friendship, sender: friend2, receiver: user)
      create(:friendship, sender: friend1, receiver: not_friend)
      create(:invitation, sender: user, receiver: invited_not_friend1)
      create(:invitation, sender: invited_not_friend2, receiver: user)

      expect(user.not_friends).to eq([not_friend])
    end
  end

  describe '#friend_with?' do
    context 'user is a friend' do
      let(:user) { create(:user) }
      let(:user2) { create(:user) }

      it 'returns true' do
        create(:friendship, sender: user, receiver: user2)

        expect(user.reload.friend_with?(user2)).to eq true
        expect(user2.reload.friend_with?(user)).to eq true
      end
    end

    context 'user is NOT a friend' do
      let(:user) { create(:user) }
      let(:user2) { create(:user) }

      it 'returns true' do
        expect(user.reload.friend_with?(user2)).to eq false
      end
    end
  end
end
