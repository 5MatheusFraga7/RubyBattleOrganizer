class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  validates_uniqueness_of :auth_token
  before_create :generate_auth_token!

  def generate_authentication_token!

    begin 
    self.auth_token = Devise.friendly_token 

    end while User.exists?(auth_token: self.auth_token)
  end

  def admin?
    self.role_id == 1 # If you have id == 1 for admin
  end

end
