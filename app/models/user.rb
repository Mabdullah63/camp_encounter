class User < ApplicationRecord
  include PgSearch::Model

  attr_accessor :skip_password_validation

  has_many :user_applications
  has_many :camps, through: :user_applications

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  # validates :first_name, presence: true, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/, message: "only accept letters" }
  # validates :country, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  # validates :phone, uniqueness: true, format: { with: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/, message: "Phone numbers must be in xxx-xxx-xxxx format." }
  # validates :country_code, presence: true, length: {minimum: 2}
  # validates :terms_of_service, acceptance: { message: 'If you do not agree to the terms and service please contact global@campencounter.com'}
  # validates :email, uniqueness: true, format: { with: /(?:\d{10}|\w+@\w+\.\w{2,3})/, message: "Enter valid Email" }
  validates :password, format: { with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/, message: " Password must contain at least (1) special character, (1) uppercase letter, (8) characters long." },if: :password_required?

  pg_search_scope :search, against: [:first_name, :last_name, :email, :created_at, :id, :country, :phone],
                   using: {
                    tsearch: { prefix: true, any_word: true}
                  }
  ADMIN = :admin.freeze
  USER = :user.freeze
  SUPER_ADMIN = :superadmin.freeze
  ROLES = [USER, SUPER_ADMIN, ADMIN]
  enum role: ROLES, _default: :user

  def name
    "#{self.first_name} #{self.last_name}"
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
