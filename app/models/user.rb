class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true

  has_secure_password
  validates :password_challenge, presence: true, on: :update, if: :password_digest_changed?

  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  after_destroy :ensure_an_admin_remains

  before_validation :clear_password_challenge

  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end

    def clear_password_challenge
      unless password_digest_changed?
        @password_challenge = nil
      end
    end
end
