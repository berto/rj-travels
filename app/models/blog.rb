class Blog < ApplicationRecord
  def to_param
   name
  end
  belongs_to :image, optional: true
end
