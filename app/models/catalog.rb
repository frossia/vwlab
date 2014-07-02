class Catalog < ActiveRecord::Base

  # def self.default_scope
    # Should return a scope, you can call 'super' here etc.
    # order('position DESC')
  # end

  acts_as_nested_set

  include TheSortableTree::Scopes

  has_many :items

  attr_accessible :name, :parent_id

  attr_protected :lft, :rgt

  validates :name, :parent_id, :presence => true

  # scope :autos_items, -> (id) {where('catalogs.depth' => 0).order(:lft) | includes(items: :autos).where('autos_items.auto_id' => id).order(:lft)}

  scope :autos_items, -> (id) {includes(items: :autos).where('autos_items.auto_id' => id).order(:lft)}

  scope :subcat, -> (cat) {where('parent_id' => cat.id).order('lft ASC')}

  # scope :john_smith, lambda { where(:name => "John") | where(:lastname => "Smith")


end
