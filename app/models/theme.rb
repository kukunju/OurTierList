class Theme < ApplicationRecord

  belongs_to :user

  has_many :tier_lists
  has_many :elements, inverse_of: :theme
  has_many :theme_tags
  has_many :theme_reports
  has_many :tags, through: :theme_tags


  accepts_nested_attributes_for :elements, allow_destroy: true, reject_if: :all_blank

def save_tag(sent_tags)

    current_tags = self.tags.pluck(:name) unless self.tags.nil?

    old_tags = current_tags - sent_tags

    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_theme_tag = Tag.find_or_create_by(name: new)
      self.tags << new_theme_tag
   end

end

def save_elements(element_list)
  element_list.each do |element_name|
    self.elements.create!(name: element_name)
  end
end

end
