class Generation < ActiveRecord::Base

  belongs_to :auto
  has_many :generation_items
  has_many :items, through: :generation_items

  validates :name, :auto_id, presence: true

  attr_accessible :auto_id, :name, :manhour

  default_scope { order('auto_id ASC') }

end
