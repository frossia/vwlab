class AutoItem < ActiveRecord::Base

  belongs_to :auto
  belongs_to :item

  attr_accessible :auto_id, :item_id, :partial_price

end
