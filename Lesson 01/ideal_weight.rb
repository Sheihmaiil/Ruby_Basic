puts "Введите Ваше имя: "
name = gets.chomp
puts "Введите Ваш вес (в кг): "
height = gets.chomp.to_i
weight = (height - 110) * 1.15

if weight < 0
  puts "#{name},  Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш идеальный вес:  #{weight} кг."
end

