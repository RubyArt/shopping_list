require 'rails_helper'

describe Membership do
  describe '#to_s' do
    it 'returns user' do
      user = create(:user, first_name: 'Wanda', last_name: 'Maximoff')
      membership = create(:membership, user: user)

      expect(membership.to_s).to eq(user)
    end
  end
end
