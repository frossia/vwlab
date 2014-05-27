# 10.times do
#
# p = Faker::Commerce.product_name
# puts p
# end

  # manhour = rand(200..400)
Item.all.each do |item|
  item.install_hours = rand(1..30)
  item.save
  puts item.install_hours
  puts '--------------------------------------------------'
end

Auto.all.each do |item|
  item.manhour = rand(200..500)
  item.save
  puts item.manhour
  puts '--------------------------------------------------'
end