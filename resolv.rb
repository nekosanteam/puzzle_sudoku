#!/usr/bin/ruby

def x_y_n(x,y,n)
  return (n + x*9 + y*81)
end

def at_least_n()
  count = 0
  (0..8).each {|y|
    (0..8).each {|x|
      (1..9).each {|n|
        print "#{x_y_n(x,y,n)} "
      }
      print "0\n"
      count += 1
    }
  }
  return count
end

def at_least_x(y)
  count = 0
  (1..9).each {|n| 
    (0..8).each {|x|
      print "#{x_y_n(x,y,n)} "
    }
    print "0\n"
    count += 1
  }
  return count
end

def at_least_y(x)
  count = 0
  (1..9).each {|n| 
    (0..8).each {|y|
      print "#{x_y_n(x,y,n)} "
    }
    print "0\n"
    count += 1
  }
  return count
end

def at_once_n_in_x(n, y)
  count = 0
  (0..8).each {|x|
    (0..8).each {|i|
      if x!=i then
        print "#{-(x_y_n(x,y,n))} #{-(x_y_n(i,y,n))} 0\n"
        count += 1
      end
    }
  }
  return count
end

def at_once_n_in_y(n, x)
  count = 0
  (0..8).each {|y|
    (0..8).each {|i|
      if y!=i then
        print "#{-(x_y_n(x,y,n))} #{-(x_y_n(x,i,n))} 0\n"
        count += 1
      end
    }
  }
  return count
end

def at_once_n_in_block(n,x,y)
  count = 0
  (0..8).each {|i|
    (0..8).each {|j|
      if i!=j then
        print "#{-(x_y_n(x*3+(i%3),y*3+(i/3),n))} #{-(x_y_n(x*3+(j%3),y*3+(j/3),n))} 0\n"
        count += 1
      end
    }
  }
  return count
end

def test_line()
  at_least_x(1)
  at_least_y(0)
  at_once_n_in_x(1, 1)
  at_once_n_in_y(9, 8)
  at_once_n_in_block(1,0,0)
end

if __FILE__ == $0 then
  total = 17739
  count = 0
  exists = []

  pat = "800000000"+"003600000"+"070090200"+
        "050007000"+"000045700"+"000100030"+
        "001000068"+"008500010"+"090000400"
  pat.split(//).each_with_index {|e,i|
    if e.ord() != 0x30 then
      exists.push("#{x_y_n(i%9,i/9,e.ord()-0x30)} 0\n")
    end
  }

  #count = 0
  count = exists.size()
  total += count
  print "p cnf 729 #{total}\n"
  count += at_least_n()
  (0..8).each {|y| count += at_least_x(y)}
  (0..8).each {|x| count += at_least_y(x)}
  (1..9).each {|n| (0..8).each {|y| count += at_once_n_in_x(n, y)} }
  (1..9).each {|n| (0..8).each {|x| count += at_once_n_in_x(n, x)} }
  (1..9).each {|n| (0..8).each {|i| count += at_once_n_in_block(n,i%3,i/3)} }
  exists.each {|e| print e}
  #STDERR.print("#{count}\n")
end
