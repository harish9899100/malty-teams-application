class Organization < ApplicationRecord
   attr_accessor :invite_user_name, :invite_user_email
  belongs_to :admin_user
  has_many :teams, dependent: :destroy
  has_many :users

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "email", "created_at", "updated_at"]
  end
end
