class Element < ApplicationRecord

  belongs_to :theme

  has_many :selected_elements

end
