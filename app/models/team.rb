class Team < ApplicationRecord
  belongs_to :organization
  has_many :users, dependent: :nullify
  has_one :admin_user, through: :organization

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "organization_id", "admin_user_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["organization", "users", "admin_user"]
  end
end
