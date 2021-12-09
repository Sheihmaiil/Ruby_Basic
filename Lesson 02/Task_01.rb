mounth= {'January' => 31, 'February' => 28, 'March' => 31, 'April' => 30, 'May' => 31, 'June' => 30, 'July' => 31, 'August' => 31, 'September' => 30, 'October' => 31, 'November' => 30, 'December' => 31}

mounth.each_pair do |key, value|
  if value == 30
    puts "#{key} => #{value}" 
  end
end
