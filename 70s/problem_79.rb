# frozen_string_literal: true

def match(passcode_candidate, correct_attempt)
  passcode_candidate.match?(/[0-9]*#{correct_attempt[0]}[0-9]*#{correct_attempt[1]}[0-9]*#{correct_attempt[2]}[0-9]*/)
end

attempts = File.read('p079_keylog.txt').split('\n')[0..1]
# lol brute force
# p (1..).find { |i| attempts.reduce(true) { |memo, attempt| memo && p(i).to_s.match?(attempt) } }

# just did it by hand, see p079_keylog_scratch.txt
