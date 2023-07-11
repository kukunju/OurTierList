class TierList < ApplicationRecord

  belongs_to :theme
  belongs_to :user

  has_many :comments
  has_many :favorites
  has_many :selected_elements


end
