class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  has_many :comments, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'


  def full_name
    "#{first_name} #{last_name}"
  end
end
