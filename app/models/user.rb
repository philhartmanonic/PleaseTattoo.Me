class User < ActiveRecord::Base
	acts_as_follower
	acts_as_followable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
    	:recoverable, :rememberable, :trackable, :validatable

    has_many :tats
    has_many :artists, through: :tats
    has_many :parlors, through: :artists
    
end
