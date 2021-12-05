printf "Введите a: "
a = gets.chomp.to_f
printf "Введите b: "
b = gets.chomp.to_f
printf "Введите c: "
c = gets.chomp.to_f

diskr = b*b - 4*a*c

if diskr > 0
  puts "Корни уравнения: x1 = #{((-b - Math.sqrt(diskr))/(2*a))}, x2 = #{((-b + Math.sqrt(diskr))/(2*a))}"
elsif diskr == 0
  puts "Корни уравнения: x1 = x2 = #{-b/(2*a)}"
elsif diskr < 0
  puts "Корней нет"
end
