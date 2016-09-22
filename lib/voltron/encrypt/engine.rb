module Voltron
  class Encrypt
    class Engine < Rails::Engine

      isolate_namespace Voltron

      initializer "voltron.encrypt.initialize" do
        ::ActiveRecord::Base.send :extend, ::Voltron::Encryptable
      end

    end
  end
end
