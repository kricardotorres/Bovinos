class User < ApplicationRecord 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :arduino_devices
  acts_as_token_authenticatable
 devise :database_authenticatable, :rememberable, :trackable, :validatable
   has_one :veterinary
   belongs_to :role  
   before_validation :erase , on: :delete   
  def erase 
    soft_delete
  end 
  def full_name
    self.name + " " + self.lastname
  end
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end
end