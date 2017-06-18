class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups, through: :memberships
  has_many :memberships, inverse_of: :user
  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id

  validates :email, :first_name, :last_name, presence: true
end
