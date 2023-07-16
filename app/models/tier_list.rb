class TierList < ApplicationRecord

  belongs_to :theme
  belongs_to :user

  has_many :comments
  has_many :favorites
  has_many :selected_elements

  scope :new_order, -> { order(created_at: :desc) }
  scope :old_order, -> { order(created_at: :asc) }
  scope :order_many_favorites, -> {
    left_joins(:favorites)
      .group('tier_lists.id')
      .order('COUNT(favorites.id) DESC')
  }


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


end
