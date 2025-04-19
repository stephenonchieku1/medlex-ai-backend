class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  def invalidate_token
    regenerate_auth_token
  end
end 