class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  mount_uploaders :photos, PhotoUploader
  ratyrate_rater
  has_many :requests, :dependent => :destroy
  has_many :events, through: :requests, :dependent => :destroy
  has_many :events
  has_many :reviews, :dependent => :destroy
  has_many :children, :dependent => :destroy
  accepts_nested_attributes_for :children
  has_many :notifications, foreign_key: :recipient_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      name_array = auth.info.name.split(" ")
      user.first_name = name_array[0..-2].join(" ")
      user.last_name = name_array.last
      user.avatar = auth.info.image
      user.user_type = "user"
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
