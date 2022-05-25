#!/usr/bin/ruby

def pos_n(n)
    return "#{((n-1)%9)+1}"
end

if __FILE__ == $0 then
    line = ARGF.gets()
    exit(1) unless /sat/i === line
    line = ARGF.gets()
    count = 0
    line.split(/\s+/).each {|n|
        if n.to_i > 0 then
            print pos_n(n.to_i)
            if count % 9 == 8 then
                print "\n"
            end
            count += 1
        end
    }
end
