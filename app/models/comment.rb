class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :tier_list

  has_many :comment_reports

  validates :comment, length: { in: 1..200 }

end
