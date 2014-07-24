class Item < ActiveRecord::Base

  default_scope { order('position asc') }

  scope :promo, where(old_price: '')

  has_many :item_attachments
  has_many :properties
  has_many :generation_items
  has_many :generations, through: :generation_items
  belongs_to :catalog

  accepts_nested_attributes_for :properties, :allow_destroy => true
  accepts_nested_attributes_for :generations
  accepts_nested_attributes_for :item_attachments, :allow_destroy => true
  accepts_nested_attributes_for :generation_items, :allow_destroy => true

  attr_accessible :name, :description, :install_hours, :price, :old_price, :partial_price, :catalog_id, :generation_ids, :generation_items_attributes, :property_ids, :properties_attributes, :item_attachments_attributes, :keywords, :position

  # validates :catalog_id, :name, :

  acts_as_list

  scope :without_category, {
      :joins      => "LEFT JOIN catalogs_items ON items.id = catalogs_items.item_id",
      :conditions => "catalogs_items.item_id IS NULL"
  }

  def self.search(search)
    unless search.blank?
      sss = search
      Item.where('LOWER(name) LIKE ?', "%#{sss}%") | where('LOWER(description) LIKE ?', "%#{sss}%") | joins(:generations).where('LOWER(generations.name) LIKE ?', "%#{sss}%")
    else
      all
    end
  end



end
