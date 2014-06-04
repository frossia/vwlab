class Item < ActiveRecord::Base

  has_many :generation_items
  has_many :generations, through: :generation_items
  has_and_belongs_to_many :catalogs

  accepts_nested_attributes_for :generations
  accepts_nested_attributes_for :generation_items, :allow_destroy => true
  accepts_nested_attributes_for :catalogs

  attr_accessible :name, :description, :old_price, :partial_price, :catalog_ids, :generation_ids, :generation_items_attributes

  def self.search(search)
    unless search.blank?
      sss = search
      Item.where('LOWER(name) LIKE ?', "%#{sss}%") | where('LOWER(description) LIKE ?', "%#{sss}%") | joins(:generations).where('LOWER(generations.name) LIKE ?', "%#{sss}%")
      # find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      all
    end
  end



end
