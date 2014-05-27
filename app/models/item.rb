class Item < ActiveRecord::Base

  has_and_belongs_to_many :autos
  has_and_belongs_to_many :catalogs

  attr_accessible :name, :catalog_ids, :auto_ids

end
