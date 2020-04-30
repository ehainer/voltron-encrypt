require "rails_helper"

describe Voltron::Encryptable do

  let(:user) { User.new }
  let(:animal) { Animal.new }
  let(:crypt) { Voltron::Encrypt.new }

  it "should not have an encrypted id if not configured" do
    expect(animal.class.has_encrypted_id?).to eq(false)
  end

  it "has an encrypted id" do
    expect(user.class.has_encrypted_id?).to eq(true)
  end

  it "should have an `encryptable` resource once saved" do
    user.save
    expect(user.encryptable).to be_a(Voltron::Id)
  end

  it "should return a base64 encoded id as to_param" do
    user.save
    expect(user.to_param).to eq(crypt.encode(user.encryptable.id))
  end

  it "should be able to find a resource by the base64 encoded id" do
    user.save
    expect(User.find(user.to_param)).to eq(user)
  end

  it "should be able to check if exists? using base64 encoded id" do
    user.save
    expect(User.exists?(user.to_param)).to eq(true)
  end

  it "should return false if not able to find record using exists?" do
    expect(User.exists?("a_made_up_base64_id")).to eq(false)
  end

  it "should be able to destroy a resource by it's base64 encoded id" do
    user.save
    expect(User.destroy(user.to_param)).to eq(user)
  end

  it "should be able to delete a resource by it's base64 encoded id" do
    user.save
    expect(User.delete(user.to_param)).to eq(user.id)
  end

  it "should be able to reload the same resource" do
    user.save

    User.where(id: user.id).update_all(email: "test@example.com")

    expect(user.email).to be_nil
    user.reload
    expect(user.email).to eq("test@example.com")
  end

  it "should be able to reload with a lock on the given resource" do
    user.save

    User.where(id: user.id).update_all(email: "test@example.com")

    expect(user.email).to be_nil
    user.reload(lock: true)
    expect(user.email).to eq("test@example.com")

    user2 = User.find(user.to_param)
    user2.phone = "1234567890"
    user2.save!
  end

  it "should call default exists? if argument is not a string" do
    user.save
    expect(User.exists?).to eq(true)
  end

  it "will properly decrypt an id before attempting to find it by GID" do
    user.save
    user_gid = user.to_global_id
    expect(GlobalID::Locator.locate(user_gid)).to eq(user)
  end

end