class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, presence: true, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+\z/, message: "only accept letters" }
  validates :country, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :phone, uniqueness: true, format: { with: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/, message: "Phone numbers must be in xxx-xxx-xxxx format." }
  validates :country_code, presence: true, length: {minimum: 2}
  validates :terms_of_service, acceptance: { message: 'If you do not agree to the terms and service please contact global@campencounter.com'}
  validates :email, uniqueness: true, format: { with: /(?:\d{10}|\w+@\w+\.\w{2,3})/, message: "Enter valid Email" }
  validates :password, format: { with: /(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}/, message: " Password must contain at least (1) special character, (1) uppercase letter, (8) characters long." }

  ADMIN = :admin
  USER = :user
  SUPER_ADMIN = :superadmin
  ROLES = [USER, SUPER_ADMIN, ADMIN]
  enum role: ROLES

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= USER
  end
end
