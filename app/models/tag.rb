class Tag < ApplicationRecord

  has_many :theme_tags
  has_many :themes, through: :theme_tags

end
