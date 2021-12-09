letters = ('a'..'z').to_a
vowel_letters = ['a','e', 'i', 'o', 'u', 'y']

my_hash = {}

for i in 0..vowel_letters.length - 1
  pos = letters.index(vowel_letters[i])
  my_hash[letters[pos]] = pos + 1
end

puts "#{my_hash}"
