# frozen_string_literal: true

require 'set'

reduced_fracs = Set.new
(2..12_000).each { |d| (((p(d) + 1) / 3.0).ceil..((d - 1) / 2.0).floor).each { |n| reduced_fracs.add(Rational(n, d)) } }
p reduced_fracs.size
