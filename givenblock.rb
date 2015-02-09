def arithmetic_sequence(init: 1, diff: 1, count: 10)
  current = init
  if block_given?
    count.times do
      yield(current, diff)
      current += diff
    end
  else
    Array.new.tap do |a|
      count.times do
        a << current
        current += diff
      end
    end
  end
end

@name = 'Charlie'
def reset_name
  @name.tap { |n| n.concat("aaaa") }
end

p reset_name
p @name

arithmetic_sequence(init: 2, diff: 3, count: 5) do |n, m|
  puts "#{n}+#{m}"
end
 
p arithmetic_sequence(init: 2, diff: 3, count: 5)


