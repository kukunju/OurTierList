class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  
  has_many :themes
  has_many :tier_lists
  has_many :favolites
  has_many :comments
  has_many :comment_report
  has_many :theme_report

end
