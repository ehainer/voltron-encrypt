module Voltron
  class Encrypt
    class Engine < Rails::Engine

      isolate_namespace Voltron

      initializer "voltron.encrypt.initialize" do
        ::ActiveRecord::Base.send :extend, ::Voltron::Encryptable
        ::ActiveRecord::Associations::CollectionAssociation.send :prepend, ::Voltron::Encrypt::ActiveRecord::CollectionAssociation

        # Corrects sidekiq resource lookup by forcing it to find_by_id rather than find with the model id
        # We either want it to find with to_param value, or find_by_id with the actual id, this is the latter
        ::GlobalID::Locator.use Rails.application.railtie_name.remove("_application").dasherize do |gid|
          gid.model_class.find_by_id gid.model_id
        end
      end

    end
  end
end
