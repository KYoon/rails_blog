class User < ActiveRecord::Base
  has_secure_password

  has_many :articles, foreign_key: :creator_id
  has_many :comments

  validates_uniqueness_of :username, :email
  validates_presence_of :username, :email


  def self.authenticate(email, password)
    User.find_by(email: email).try(:authenticate, password)
  end
end
