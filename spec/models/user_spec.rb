require 'rails_helper'

describe User do
  it('has valid factory') { expect(build(:user)).to be_valid }
  it { is_expected.to validate_presence_of :password }
  it do
    is_expected.to validate_length_of(:password)
      .is_at_least(Devise.password_length.first)
      .is_at_most(Devise.password_length.last)
  end
  it { is_expected.to validate_confirmation_of :password }
  it { is_expected.to have_many(:groups).through(:memberships) }
  it { is_expected.to have_many(:memberships).inverse_of(:user) }
  it { is_expected.to have_many(:owned_groups).class_name('Group').with_foreign_key(:owner_id) }
end
