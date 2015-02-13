class Array
  def iterate!
    self.each_with_index do |item, idx|
      self[idx] = yield(item)
    end
  end
end

array = [1, 2, 3, 4]
array.map! do |n|
  n ** 2
end
puts array.inspect

array = [1, 2, 3, 4]
array.iterate! do |item|
  item ** 2
end
puts array.inspect
 

def repeat(n, b)
  for i in 1..n
    puts i
    puts b.call
  end
end


p = lambda { puts "proc"; return "return from proc" }
repeat(3, p)

 
