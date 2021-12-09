a = 0
b = 1
c = 0

fibb = [a]

while b < 100 do
  
  fibb << b
  c = a + b
  a = b
  b = c
  
end

puts "#{fibb}"
