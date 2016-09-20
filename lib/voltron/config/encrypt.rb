module Voltron
	class Config

		def encrypt
			@encrypt ||= Encrypt.new
		end

		class Encrypt

			attr_accessor :offset, :seed, :blacklist

			def initialize
				@offset ||= 64
				@seed ||= nil
				@blacklist ||= Rails.root.join("config", "locales", "blacklist.txt")
			end
		end
	end
end