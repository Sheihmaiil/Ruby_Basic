print "Введите дату: "
data = gets.chomp.to_i
print "Введите месяц: "
mounth = gets.chomp.to_i
print "Ведите год: " 
year = gets.chomp.to_i

mounth_length = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

days = 0
  
for i in 0..mounth-2
  days += mounth_length[i ]
end

days += data

if days > 60

  if year%4 == 0
    days += 1
  end  

  if year%100 == 0
    days -= 1
  end

  if year%400 == 0
    days += 1
  end

end  

puts "Дней с начала года: #{days}"

