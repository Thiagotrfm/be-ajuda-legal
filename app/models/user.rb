class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
  validates :phone, length: { is: 11 }, presence: true
end
