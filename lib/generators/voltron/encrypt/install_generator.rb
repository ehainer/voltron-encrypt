module Voltron
  class Encrypt
    module Generators
      class InstallGenerator < Rails::Generators::Base

        source_root File.expand_path("../../../templates", __FILE__)

        desc "Add Voltron Encrypt initializer"

        def inject_initializer

          voltron_initialzer_path = Rails.root.join("config", "initializers", "voltron.rb")

          unless File.exist? voltron_initialzer_path
            unless system("cd #{Rails.root.to_s} && rails generate voltron:install")
              puts "Voltron initializer does not exist. Please ensure you have the 'voltron' gem installed and run `rails g voltron:install` to create it"
              return false
            end
          end

          current_initiailzer = File.read voltron_initialzer_path

          unless current_initiailzer.match(Regexp.new(/^# === Voltron Encrypt Configuration ===/))
            inject_into_file(voltron_initialzer_path, after: "Voltron.setup do |config|\n") do
<<-CONTENT

  # === Voltron Encrypt Configuration ===

  # The offset used in generating base64 encoded ids. A higher number means larger ids (i.e. - "7feIds" instead of "6f"),
  # but can potentially produce large base64 encoded ids
  # DON'T change this number once records whose id's are being encoded exist in the database
  # as all decoded ids will be incorrect
  # config.encrypt.offset = 262144

  # The location of the blacklist, words that should NOT be permitted in the form of generated ids
  # Each word should be on it's own line, and only contain [A-Z], no spaces, dashes, underscores, or numbers
  # Each word is automatically matched against it's literal, case-insensitive, and l33t spellings, with dashes
  # and underscores optionally preceding/following each character.
  # i.e. - the blacklist word "toke" will match [toke, tOKE, 7oke, t0k3, t-o-k-e, -t0--k3--, etc...]
  # config.encrypt.blacklist = Rails.root.join("config", "locales", "blacklist.txt")

  # The seed used to randomize base 64 characters. Once set, it should NOT EVER be changed.
  # Doing so will result in incorrect decoded ids, followed by large crowds with pitchforks and torches
  # Running `rake secret` is a good way to generate a random seed for this config value
  # config.encrypt.seed = ""
CONTENT
            end
          end
        end

        def copy_blacklist
          unless File.exist? Rails.root.join("config", "locales", "blacklist.txt")
            copy_file "config/locales/blacklist.txt", Rails.root.join("config", "locales", "blacklist.txt")
          end
        end

        def copy_migrations
          copy_migration "create_voltron_ids"
        end

        protected

          def copy_migration(filename)
            if migration_exists?(Rails.root.join("db", "migrate"), filename)
              say_status("skipped", "Migration #{filename}.rb already exists")
            else
              copy_file "db/migrate/#{filename}.rb", Rails.root.join("db", "migrate", "#{migration_number}_#{filename}.rb")
            end
          end

          def migration_exists?(dirname, filename)
            Dir.glob("#{dirname}/[0-9]*_*.rb").grep(/\d+_#{filename}.rb$/).first
          end

          def migration_id_exists?(dirname, id)
            Dir.glob("#{dirname}/#{id}*").length > 0
          end

          def migration_number
            @migration_number ||= Time.now.strftime("%Y%m%d%H%M%S").to_i

            while migration_id_exists?(Rails.root.join("db", "migrate"), @migration_number) do
              @migration_number += 1
            end

            @migration_number
          end
      end
    end
  end
end