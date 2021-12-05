printf "Введите длину стороны a: "
a = gets.chomp.to_f
printf "Введите длину стороны b: "
b = gets.chomp.to_f
printf "Введите длину стороны c: "
c = gets.chomp.to_f

type_of_triangle = 0

#
# Type_of_triangle
# 0 - абстрактный треугольник
# 1 - равносторонний и, соответственно, равнобедренный
# 2 - просто равнобедренный
# 3 - равнобедренный и прямоугольный
# 4 - просто прямоугольный

if (a == b) && (b == c) && (c == a)
  type_of_triangle = 1
end
  
if (a == b) || (b == c) || (c == a)
  
  if type_of_triangle == 0
    type_of_triangle = 2
  end

end
  
if (a*a == b*b+c*c) || (b*b == a*a+c*c) || (c*c == a*a+b*b)
  
  if type_of_triangle == 2
    type_of_triangle += 1
  else
    type_of_triangle = 4
  end

end

case type_of_triangle
when 0
  puts "Абстрактный треугольник"
when 1
  puts "Равносторонний треугольник"
when 2
  puts "Равнобедренный треугольник"
when 3
  puts "Равнобедренный и прямоугольный треугольник"
when 4
  puts "Прямоугольный треугольник"
end
