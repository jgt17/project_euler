# frozen_string_literal: true

require 'prime'

# challenged myself to do everything in one line for this one, just for fun
p(Prime.find { |prime| [0, 1].repeated_permutation(prime.to_s.length).filter { |s| s.zip(prime.digits.reverse_each).reduce(-1) { |memo, z| z[0].zero? ? memo : memo == -1 ? z[1] : memo == z[1] ? memo : false}}.map { |s| (s[0].zero? ? (0..9) : (1..9)).map { |r| s.zip(prime.digits.reverse_each).map { |b, d| (b - 1) * -d + b * r }.reduce { |memo, el| memo * 10 + el} }.reduce(0) { |memo, el| Prime.prime?(el) ? memo + (s[0].zero? ? 1 : -1) : memo } }. reduce(false) { |memo, el| memo || el.abs >= 8 && -9 < el && el < 10 } })
