require 'rails_helper'

describe Group do
  describe '.create' do
    it 'adds membership for owner' do
      user = create(:user)
      expect { Group.create(name: 'Avengers', owner: user) }.to(change { Membership.count })

      group = Group.find_by(name: 'Avengers')
      expect(Membership.where(group: group, user: user).count).to eq(1)
    end
  end

  describe '#to_s' do
    it 'returns name' do
      group = create(:group, name: 'Avengers')
      expect(group.to_s).to eq('Avengers')
    end
  end

  describe '#owner?' do
    context 'user is a group owner' do
      let(:user) { create(:user) }
      let(:group) { create(:group, owner: user) }

      it 'returns true' do
        expect(group.owner?(user)).to eq true
      end
    end

    context 'user is NOT a group owner' do
      let(:user) { create(:user) }
      let(:group) { create(:group) }

      it 'returns true' do
        expect(group.owner?(user)).to eq false
      end
    end
  end

  describe '#memeber?' do
    context 'user is a group member' do
      let(:user) { create(:user) }
      let(:group) { create(:group) }

      it 'returns true' do
        create(:membership, group: group, user: user)

        expect(group.reload.member?(user)).to eq true
      end
    end

    context 'user is NOT a group member' do
      let(:user) { create(:user) }
      let(:group) { create(:group) }

      it 'returns true' do
        expect(group.reload.member?(user)).to eq false
      end
    end
  end
end
