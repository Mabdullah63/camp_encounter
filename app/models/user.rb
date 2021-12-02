class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include PgSearch::Model

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  FIRST_NAME_COUNTRY_REGEX = (/\A[a-zA-Z]+\z/).freeze
  PHONE_REGEX = (/\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/).freeze
  EMAIL_REGEX = (/(?:\d{10}|\w+@\w+\.\w{2,3})/).freeze
  PASSWORD_REGEX = (/(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/).freeze

  validates :first_name, presence: true, length: { minimum: 2 }, format: { with: FIRST_NAME_COUNTRY_REGEX, message: "only accept letters" }
  validates :country, presence: true, format: { with: FIRST_NAME_COUNTRY_REGEX, message: "only allows letters" }
  validates :phone, uniqueness: true, format: { with: PHONE_REGEX, message: "Phone numbers must be in xxx-xxx-xxxx format." }
  validates :country_code, presence: true, length: { minimum: 2 }
  validates :terms_of_service, acceptance: { message: 'If you do not agree to the terms and service please contact global@campencounter.com'}
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX, message: "Enter valid Email" }
  validates :password, format: { with: PASSWORD_REGEX, message: "Password must contain at least (1) special character, (1) uppercase letter, (8) characters long." }

  pg_search_scope :search, against: [:first_name, :last_name, :email, :created_at, :id, :country, :phone],
                  using: {
                    tsearch: { prefix: true, any_word: true}
                  }
  
  ADMIN = :admin.freeze
  USER = :standard_user.freeze
  SUPER_ADMIN = :superadmin.freeze
  
  ROLES = [USER, SUPER_ADMIN, ADMIN]
  enum role: ROLES

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= USER
  end
end
