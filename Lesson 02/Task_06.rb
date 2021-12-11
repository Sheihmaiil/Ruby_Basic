my_hash = {}

loop do
  
  printf "Введите наименование товара: "
  product = gets.chomp
  break if product == "стоп"
  
  printf "Введите цену товара: "
  price = gets.chomp
  
  printf "Введите количество товара: "
  quantity = gets.chomp.to_f

  puts ""

  my_hash[product] = {price => quantity}
end

puts ""
puts "#{my_hash}"
puts ""

total = 0
count = 1

my_hash.each {|keys, value|

  puts "#{count}. #{keys}"
  
  tmp_array = value.shift

  puts "Цена за ед.: #{tmp_array[0].to_f}, количество товара: #{tmp_array[1].to_f}, Стоимость: #{tmp_array[0].to_f * tmp_array[1].to_f}"
  puts ""

  total += tmp_array[0].to_f * tmp_array[1].to_f
  count += 1
  
  }

puts "---------------------------------------------------------------"
puts "Общая стоимость товара в корзине: #{total}"


