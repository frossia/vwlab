class GenerationItem < ActiveRecord::Base

  belongs_to :generation
  belongs_to :item

  attr_accessible :generation_id, :item_id, :install_hours, :dop_price

  # default_scope { includes(generation: :auto).order('auto_id ASC') }

  # validates :generation_id, :presence => true

end
