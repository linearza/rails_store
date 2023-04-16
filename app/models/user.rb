class User < ApplicationRecord
  has_secure_password

  enum role: [:user, :admin]

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def self.from_token_payload(payload)
    find payload['sub']
  end
end
