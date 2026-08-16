class User < ApplicationRecord
  belongs_to :organization, optional: true
  belongs_to :team, optional: true, optional: true
  #enum role: { member: 0, manager: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      #user.first_name = auth.info.first_name || auth.info.name.split(' ').first
      #user.last_name = auth.info.last_name || auth.info.name.split(' ').last
      # Add any other fields you want to save
    end
  end

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

  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end
  
end
