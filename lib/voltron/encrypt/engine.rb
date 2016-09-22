require "voltron/encryptable"

module Voltron
	class Encrypt
		class Engine < Rails::Engine

			initializer "voltron.encrypt.initialize" do
				::ActiveRecord::Base.send :extend, ::Voltron::Encryptable
			end

		end
	end
end