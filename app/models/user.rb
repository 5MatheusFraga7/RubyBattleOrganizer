class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  has_many :dungeon_masters
  has_many :players

  validates_uniqueness_of :auth_token
  before_create :generate_authentication_token!

  def generate_authentication_token!

    begin 
    self.auth_token = Devise.friendly_token 

    end while User.exists?(auth_token: self.auth_token)
  end

  def admin?
    
    # If you have id == 1 for admin
    # If you have id == 2 for sample

    self.role_id == 1 
  end

  def get_dungeon_master(dungeon_master_id)

    if (dungeon_master_id.nil?)

      return []

    end

    self.dungeon_masters.where(id: dungeon_master_id.to_i).first

  end

end
