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

puts "#{my_hash}"

total = 0
count = 1

my_hash.each {|keys, value|

  puts "#{count}. #{keys}"
  
  tmp_array = value.shift

  a1 = tmp_array[0].to_f
  a2 = tmp_array[1].to_f
  a3 = (a1 * a2)
  a3 = a3.round(2)

  puts "Цена за ед.: #{a1}, количество товара: #{a2}, Стоимость: #{a3}"
  
  total += a3
  count += 1
  
  }

puts "---------------------------------------------------------------"
puts "Общая стоимость товара в корзине: #{total}"


