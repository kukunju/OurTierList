class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :tier_list

  has_many :comment_reports

  validates :comment, length: { in: 1..200 }
  
  #倫理削除したものを非表示
  scope :active, -> { where(is_deleted: false) }

end
