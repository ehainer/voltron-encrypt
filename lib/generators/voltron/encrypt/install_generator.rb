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

          unless current_initiailzer.match(Regexp.new(/^\s# === Voltron Encrypt Configuration ===\n/))
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
          copy_file "db/migrate/create_voltron_ids.rb", Rails.root.join("db", "migrate", "#{Time.now.strftime("%Y%m%d%H%M%S")}_create_voltron_ids.rb")
        end
      end
    end
  end
end