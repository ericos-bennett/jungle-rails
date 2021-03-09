class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  validates_length_of :password, minimum: 5
  validates_length_of :password_confirmation, minimum: 5

  validates_uniqueness_of :email

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end

end
