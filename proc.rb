class Array
  
  # for proc
  def iterate!(code)
    self.each_with_index do |item, idx|
      self[idx] = code.call(item)
    end
  end

  # for block
  def iterate_blk!(&code)
    self.each_with_index do |item, idx|
      self[idx] = code.call(item)
    end
  end

end
 
def who_am_i(&block)
 
  # blockは単にProcだったのです
 puts block.class
end

def callbacks(procs)
  puts procs.class
  procs[:starting].call
  puts "Still going"
  procs[:finishing].call
end
 
array_1 = [1, 2, 3, 4]
  array_2 = [2, 3, 4, 5]
  array_3 = [3, 4, 5, 6]
  
square_block = Proc.new { |n| n**2 }
  
  array_1.iterate!(square_block)
  array_2.iterate!(square_block)
  array_3.iterate_blk! { |n| n**2 }


puts array_1.inspect
  puts array_2.inspect
  puts array_3.inspect


 
callbacks(:starting => Proc.new { puts "Starting" },
          :finishing => Proc.new { puts "Finishing" })

    
  who_am_i { }

  