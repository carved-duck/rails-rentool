class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tools
  has_many :rentals
  has_many :rentals_as_owner, through: :tools, source: :rentals
  validates :name, presence: true
  validates :email, presence: true
end
