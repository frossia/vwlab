class Generation < ActiveRecord::Base

  belongs_to :auto
  has_many :generation_items
  has_many :items, through: :generation_items

  attr_accessible :auto_id, :name, :manhour

end
