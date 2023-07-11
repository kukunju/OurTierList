class ThemeTag < ApplicationRecord

  belongs_to :theme
  belongs_to :tag

  validates :theme_id, presence: true
  validates :tag_id, presence: true

end
