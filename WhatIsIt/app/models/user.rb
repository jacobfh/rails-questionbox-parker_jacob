# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  username        :string
#  password_digest :string
#  api_token       :string
#

class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_one_attached :image
  
  has_secure_password
  has_secure_token :api_token
  
  validates :username, presence: true
  validates_uniqueness_of :username
  validates :password_digest, presence: true


  def to_s
    username
  end
end
