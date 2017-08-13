class Blog < ApplicationRecord
  def to_param
   name
  end
end
