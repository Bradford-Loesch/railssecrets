class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :email, presence: true
  validates :password, presence: true, on: :create
  validates :email, uniqueness: {case_sensitive: false}, format: { with: EMAIL_REGEX }
  has_secure_password
  # before_save do
  #   self.email.downcase!
  # end
end
