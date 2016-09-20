require "rails_helper"

describe Voltron::Encrypt do

	let(:encrypt) { Voltron::Encrypt.new }

	it "has a version number" do
		expect(Voltron::Encrypt::VERSION).not_to be nil
	end

	it "has a blacklist file" do
		expect(File.exist?(Voltron.config.encrypt.blacklist)).to eq(true)
	end

	it "can base64 encode an integer" do
		expect(encrypt.encode(1234567890)).to eq("d-IPL0")
	end

	it "can decode a base64 encoded value" do
		expect(encrypt.decode("d-IPL0")).to eq(1234567890)
	end

	it "should be able to identify values that match blacklisted words" do
		# 6107072 == encoded "butt"
		expect(encrypt.blacklisted?(6107072)).to eq(true)
	end

end
