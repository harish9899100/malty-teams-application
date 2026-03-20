class AdminUser < ApplicationRecord
  has_many :organizations, dependent: :destroy
  has_many :teams, through: :organizations
  has_many :users, through: :organization

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "email", "created_at", "updated_at"]
  end
end
