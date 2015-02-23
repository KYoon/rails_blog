class User < ActiveRecord::Base
  has_many :articles, foreign_key: :creator_id
  has_many :comments

  validates_uniqueness_of :username, :email
  validates_presence_of :username, :email, :password_hash

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    return user if user && (user.password == password)
    nil
  end
end
