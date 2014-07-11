module ApplicationHelper

  def items_count(cat_id, auto_id)
    Item.includes(:generations).where('catalog_id' => cat_id, 'generations.auto_id' => auto_id)
    # Items.includes(items: :autos).where('catalogs.id' => cat_id, 'autos_items.auto_id' => auto_id).order(:lft)
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

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end

  def grouped_options
    catalog = Catalog.all
    go = []
    catalog.each do |cat|
      if cat.depth == 0
        go << [cat.name, cat.descendants.map { |i| ["#{i.name}", i.id] }]
      end
    end
    go
  end

  def settings_save
    File.open("config/settings.yml", 'w') { |f| YAML.dump(@settings, f) }
  end

  def title(page_title = nil)
    if page_title.present?
      content_for :title, settings_value('Название сайта', :ru).value.to_s + ' -- ' + page_title.to_s
    else
      content_for :title, Settings.title.to_s
    end
  end

  def description(content)
    content_for :description, sanitize(content.gsub(/<code[^<]*<\/code>/, ""), :tags => %w(), :attributes => %w()).gsub(/[\r\n?]/, " ").squeeze(" ").gsub(/\"/, "'")[0..250].strip
  end

  def keywords(content)
    if content
      %w[#{content}]
    end
  end

end
