class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groups , dependent: :destroy
  has_many :friends ,  dependent: :destroy
  has_many :orders  ,  dependent: :destroy
  has_many :groups_members
  has_one_attached :avatar

  has_many :friendships
  has_many :friends, :through => :friendship

devise :omniauthable,:omniauth_providers => [:google_oauth2, :facebook, :twitter, :linkedin]
# acts_as_target email: :email, email_allowed: :confirmed_at

acts_as_target 

   def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] &&     session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
end
def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name   # assuming the user model has a name
    #user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
end


end
