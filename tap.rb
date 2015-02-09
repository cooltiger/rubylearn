puts "charlie".upcase.tap{ |s| p s }.reverse.tap{ |s| p s }.gsub(/[aeiou]/i,'*')
a = [56, 87, 49, 75, 90, 63, 65].tap {|s| break s.inject(:+)/s.size  }
p a


