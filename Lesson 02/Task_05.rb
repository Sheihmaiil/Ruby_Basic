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
  print days
  gets
end

days += data

if days > 60

  if year/4.0 == year/4
    days += 1
  end  

  if year/100.0 == year/100
    days -= 1
  end

  if year/400.0 == year/400
    days += 1
  end

end  

puts "Дней с начала года: #{days}"

