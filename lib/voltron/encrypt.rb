require "voltron"
require "voltron/encrypt/version"
require "voltron/config/encrypt"
require "voltron/encryptable"
require "voltron/encrypt/active_record/collection_association"

module Voltron
  class Encrypt

    def encode(input)
      radix = digits.length
      i = input.to_i + Voltron.config.encrypt.offset.to_i # Increase the number just so we don't end up with id's like "E" or "d3" on low number ids

      raise ArgumentError.new("Value #{val} cannot be less than zero") if i < 0

      out = []
      begin
        rem = i % radix
        i /= radix
        out << digits[rem]
      end until i == 0

      out.reverse.join
    end

    def decode(input)
      inp = input.to_s.split("")
      out = 0

      begin
        chr = inp.shift
        out += (digits.length**inp.length)*digits.index(chr)
      end until inp.empty?

      out - Voltron.config.encrypt.offset.to_i # Decrease the number by the same offset amount
    end

    def blacklisted?(input)
      encoded = encode(input)

      pattern = ["\\b([_\\-])*"]
      encoded.chars.each do |c|
        subs = translations[c.downcase] || []
        c = "\\#{c}" if c == "-"
        pattern << "[#{c}#{subs.join}]([_\\-])*"
      end
      pattern << "\\b"

      regex = Regexp.new(pattern.join, Regexp::IGNORECASE)
      !blacklist(encoded.length).match(regex).nil?
    end

    def blacklist(len = 6)
      if File.exist?(Voltron.config.encrypt.blacklist.to_s)
        File.readlines(Voltron.config.encrypt.blacklist).map(&:strip).reject { |line| line.length > len }.join(" ")
      else
        ""
      end
    end

    private

      def translations
        {
          "a" => ["4"],
          "e" => ["3"],
          "i" => ["1", "l"],
          "o" => ["0"],
          "s" => ["5"],
          "t" => ["7"],
          "b" => ["8"],
          "z" => ["2"],
          "g" => ["9"]
        }
      end

      def digits
        rnd = Random.new(Voltron.config.encrypt.seed.to_s.to_i(24))
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_".chars.shuffle(random: rnd)
      end
  end
end

require "voltron/encrypt/engine" if defined?(Rails)
