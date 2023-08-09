class Theme < ApplicationRecord
  attr_accessor :tag_names, :element_names

  belongs_to :user

  has_many :tier_lists
  has_many :elements, inverse_of: :theme
  has_many :theme_tags
  has_many :theme_reports
  has_many :tags, through: :theme_tags,validate: true

  validates :name, presence: true
  validate :tags_and_elements_presence

  accepts_nested_attributes_for :elements, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: :all_blank


#倫理削除したものを非表示
  scope :active, -> { where(is_deleted: false) }

#並べ替え
  scope :new_order, -> { order(created_at: :desc) }
  scope :old_order, -> { order(created_at: :asc) }
  scope :order_many_tier_list, -> {
    left_joins(:tier_lists)
      .group('themes.id')
      .order('COUNT(tier_lists.id) DESC')
  }

  #tag,element空欄時エラー
  def tags_and_elements_presence
    errors.add(:tag_names, 'を入力してください') if tags.empty?
    errors.add(:element_names, 'を入力してください') if elements.empty?
  end

end
