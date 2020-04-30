module Voltron
  class Encrypt
    module ActiveRecord
      module CollectionAssociation

        def ids_writer(ids)
          if klass.has_encrypted_id?
            ids.reject!(&:blank?)
            records = klass.find(ids)
            replace(Array.wrap(records))
          else
            super ids
          end
        end

        def ids_reader
          if klass.has_encrypted_id?
            if loaded?
              load_target.map(&:to_param)
            else
              scope.map(&:to_param)
            end
          else
            super
          end
        end

      end
    end
  end
end
