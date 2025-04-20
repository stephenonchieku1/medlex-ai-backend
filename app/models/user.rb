# class User < ApplicationRecord
#   has_secure_password
#   has_secure_token :auth_token
  
#   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
#   validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

#   def invalidate_token
#     regenerate_auth_token
#   end
#     # Add this method to generate an auth token
#     def auth_token
#       payload = { user_id: self.id }
#       JWT.encode(payload, Rails.application.secrets.secret_key_base)
#     end
# end 
class User < ApplicationRecord
  has_secure_password
  # Remove this line - it conflicts with your auth_token method
  # has_secure_token :auth_token
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  def invalidate_token
    # This method won't work anymore since we removed has_secure_token
    # You'll need a different approach for invalidating tokens
  end
  
  # Add this method to generate an auth token
  def auth_token
    require 'jwt' # Add this line to require JWT
    payload = { user_id: self.id }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end