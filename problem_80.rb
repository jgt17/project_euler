# frozen_string_literal: true

require 'bigdecimal'

p((1..100).select { |n| !(Math.sqrt(n) % 1).zero? }.reduce(0) { |memo, n| memo + BigDecimal(n).sqrt(100).split[1].to_s.split('')[0...100].reduce(0) { |memo2, digit| memo2 + digit.to_i } })
