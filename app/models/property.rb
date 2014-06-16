class Property < ActiveRecord::Base

  belongs_to :item

  attr_accessible :item_id, :name, :value

  validates :name, :value, presence: true

end
