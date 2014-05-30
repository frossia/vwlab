class Catalog < ActiveRecord::Base

  acts_as_nested_set

  has_and_belongs_to_many :items

  attr_accessible :name, :parent_id

  attr_protected :lft, :rgt

  # scope :autos_items, -> (id) {where('catalogs.depth' => 0).order(:lft) | includes(items: :autos).where('autos_items.auto_id' => id).order(:lft)}

  scope :autos_items, -> (id) {includes(items: :autos).where('autos_items.auto_id' => id).order(:lft)}

  scope :subcat, -> (cat) {where('parent_id' => cat.id)}

  # scope :john_smith, lambda { where(:name => "John") | where(:lastname => "Smith")


end
