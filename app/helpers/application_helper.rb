module ApplicationHelper

  def items_count(cat_id, auto_id)
    Item.includes(:catalogs, :generations).where('catalogs.id' => cat_id, 'generations.auto_id' => auto_id)
    # Items.includes(items: :autos).where('catalogs.id' => cat_id, 'autos_items.auto_id' => auto_id).order(:lft)
  end

  def td_helper(i)
    i > 0 ? {:tag => 'td', :colspan => '2'} : {:tag => 'td'}
  end

  def product_for(id)
    item = Item.find(id)
    x = Array.new(Hash.new)
    if item.generations.any?
      x[0][:auto] = item.generations.first.auto.name
    end
    item.generations.eachwith_index do |g|
      x[i][:g] = g.name
    end
    x
  end

  def get_generations(item, g)
    GenerationItem.all.where(item_id: item, generation_id: g)
  end

  def get_generations_html(item, auto_id)
    g = GenerationItem.all.where(item_id: item).includes(:generation).where('generations.auto_id' => auto_id)
    body = g.map { |g| '<small>'+g.generation.name+'</small>'}
    safe_join(body, '<br />')
  end

end
