class User < ApplicationRecord
  belongs_to :organization, optional: true
  belongs_to :team, optional: true, optional: true
  #enum role: { member: 0, manager: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

def self.ransackable_associations(auth_object = nil)
  ["organization"]
end


  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "email",
      "role",
      "created_at",
      "updated_at",
      "invitation_created_at",
      "invitation_sent_at",
      "invitation_accepted_at"
    ]
  end
  
end
