module ApplicationHelper

  def items_count(cat_id, auto_id)
    Item.includes(:catalogs, :autos).where('catalogs.id' => cat_id, 'autos.id' => auto_id)
    # Items.includes(items: :autos).where('catalogs.id' => cat_id, 'autos_items.auto_id' => auto_id).order(:lft)
  end

end
