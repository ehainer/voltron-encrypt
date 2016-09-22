module Voltron
	class Encrypt
		class Railtie < Rails::Railtie

			initializer "voltron.encrypt.initialize" do
				::ActiveRecord::Base.send :extend, ::Voltron::Encryptable
			end

		end
	end
end