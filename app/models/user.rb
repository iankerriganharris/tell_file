class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
	 :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		  user.provider = auth.provider
		  user.uid = auth.uid
		  user.email = auth.info.email
		  user.password = Devise.friendly_token[0,20]
	  end
  end
end
