class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :tier_list

  has_many :comment_teports

end
