class Array
  def iterate!(code)
    self.each_with_index do |n, i|
      self[i] = code.call(n)
    end
  end
end
 
array = [1, 2, 3, 4]
 
array.iterate!(lambda { |n| n ** 2 })
 
puts array.inspect

def square(n)
  n ** 2
end
 
array = [3, 4, 5, 6]
 
array.iterate!(method(:square))
p array

puts method(:square).class
  # lambda act as method , but is Proc class
  puts lambda {}.class

def arguments(code)
  one, two = 1, 2
  code.call(one, two)
end
 
arguments(Proc.new { |a, b, c| puts "Give me a #{a} and a #{b} and a #{c.class}" })

  # get error below because lambda has no parameter check 
# arguments(lambda { |a, b, c| puts "Give me a #{a} and a #{b} and a #{c.class}" })
  
def proc_return
  Proc.new { return "Proc.new"}.call
  return "proc_return method finished"
end
 
def lambda_return
  lambda { return "lambda" }.call
  return "lambda_return method finished"
end
 
puts proc_return
puts lambda_return
 
  
  
def generic_return(code)
  one, two    = 1, 2
  three, four = code.call(one, two)
  return "Give me a #{three} and a #{four}"
end
 
puts generic_return(lambda { |x, y| return x + 2, y + 2 })
 
  # get error below because Proc is not method but code snippet
  # error: unexpected return (LocalJumpError) 
# puts generic_return(Proc.new { |x, y| return x + 2, y + 2 })
 
puts generic_return(Proc.new { |x, y| x + 2; y + 2 })
 
puts generic_return(Proc.new { |x, y| [x + 2, y + 2] })