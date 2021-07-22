require 'set'

terms = Set.new

(2..100).each { |a| (2..100).each { |b| terms.add a**b } }

puts terms.size
