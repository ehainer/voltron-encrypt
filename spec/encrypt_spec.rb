require "rails_helper"

describe Voltron::Encrypt do

  let(:encrypt) { Voltron::Encrypt.new }

  it "has a version number" do
    expect(Voltron::Encrypt::VERSION).not_to be nil
  end

  it "has a blacklist file" do
    expect(File.exist?(Voltron.config.encrypt.blacklist)).to eq(true)
  end

  it "has an empty blacklist string if the blacklist file does not exist" do
    Voltron.config.encrypt.blacklist = "missing_file.txt"

    expect(encrypt.blacklist).to be_blank

    Voltron.config.encrypt.blacklist = Rails.root.join("config", "locales", "blacklist.txt")
  end

  it "can base64 encode an integer" do
    expect(encrypt.encode(1234567890)).to eq("lHaoh3")
  end

  it "can decode a base64 encoded value" do
    expect(encrypt.decode("lHaoh3")).to eq(1234567890)
  end

  it "should be able to identify values that match blacklisted words" do
    # 16397913 == encoded "butt"
    expect(encrypt.blacklisted?(16397913)).to eq(true)
  end

end
