class GenerationItem < ActiveRecord::Base

  belongs_to :generation
  belongs_to :item

  attr_accessible :generation_id, :item_id, :dop_price

end
