Voltron.setup do |config|

  # === Voltron Encrypt Configuration ===

  # The offset used in generating base64 encoded ids. A higher number means larger ids (i.e. - "7feIds" instead of "6f"),
  # but can potentially produce large base64 encoded ids
  # DON'T change this number once records whose id's are being encoded exist in the database
  # as all decoded ids will be incorrect
  config.encrypt.offset = 262144

  # The location of the blacklist, words that should NOT be permitted in the form of generated ids
  # Each word should be on it's own line, and only contain [A-Z], no spaces, dashes, underscores, or numbers
  # Each word is automatically matched against it's literal, case-insensitive, and l33t spellings, with dashes
  # and underscores optionally preceding/following each character.
  # i.e. - the blacklist word "toke" will match [toke, tOKE, 7oke, t0k3, t-o-k-e, -t0--k3--, etc...]
  config.encrypt.blacklist = Rails.root.join("config", "locales", "blacklist.txt")

  # The seed used to randomize base 64 characters. Once set, it should NOT EVER be changed.
  # Doing so will result in incorrect decoded ids, followed by large crowds with pitchforks and torches
  # Running `rake secret` is a good way to generate a random seed for this config value
  config.encrypt.seed = ""

  # === Voltron Base Configuration ===

  # Whether to enable debug output in the browser console and terminal window
  # config.debug = false

  # The base url of the site. Used by various voltron-* gems to correctly build urls
  # config.base_url = "http://localhost:3000"

  # What logger calls to Voltron.log should use
  # config.logger = Logger.new(Rails.root.join("log", "voltron.log"))

end