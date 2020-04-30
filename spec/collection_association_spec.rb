require "rails_helper"

describe Voltron::Encrypt::ActiveRecord::CollectionAssociation do

  let(:user) { User.new }

  let(:car1) { Car.create(name: "Car 1") }
  let(:car2) { Car.create(name: "Car 2") }
  let(:car3) { Car.create(name: "Car 3") }

  let(:animal1) { Animal.create(name: "Animal 1") }
  let(:animal2) { Animal.create(name: "Animal 2") }
  let(:animal3) { Animal.create(name: "Animal 3") }

  it "will find resources by encrypted ids before replacing the associated values" do
    expect(user.cars.size).to eq(0)
    user.update(car_ids: [car1.to_param, car2.to_param, car3.to_param])
    expect(user.cars.size).to eq(3)
  end

  it "will run default ids_writer action if association class does not encrypt ids" do
    expect(user.animals.size).to eq(0)
    user.update(animal_ids: [animal1.to_param, animal2.to_param, animal3.to_param])
    expect(user.animals.size).to eq(3)
  end

end
