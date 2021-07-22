# frozen_string_literal: true

@encrypted = File.read('p059_cipher.txt').split(',').map(&:to_i)
@words = File.read('words.txt').split

def multi_xor(msg, key)
  decrypted = msg.each_with_index.map { |val, index| (val ^ key[index % key.length]).chr }.reduce(&:concat)
  matches = 0
  @words.each do |word|
    next unless decrypted.include? word

    matches += 1
    next unless matches > 50

    p decrypted
    p key
    p msg.each_with_index.map { |val, index| (val ^ key[index % key.length]) }.reduce(&:+)
    break
  end
end

def manual_decrypt
  (97..122).each do |a|
    (97..122).each do |b|
      (97..122).each do |c|
        multi_xor(@encrypted, [a, b, c])
      end
    end
  end
end

manual_decrypt

# [101, 120, 112]