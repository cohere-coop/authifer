class User < ActiveRecord::Base
  validates :password, confirmation: true, presence: true
  validates :email, uniqueness: true
end
