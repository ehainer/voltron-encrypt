require 'benchmark'

cars = [
  "Camry",
  "Rogue",
  "Murano",
  "Tacoma",
  "Tundra",
  "Outback",
  "Forester",
  "Pathfinder",
  "4Runner",
  "Edge",
  "Blazer"
]

cars.each do |car|
  if !Car.exists?(name: car)
    Car.create(name: car)
  end
end

time = Benchmark.measure {
  1000.times do |n|
    User.create
  end
}
puts "Time to create 1000 users (encrypted id): #{time.real}"

time = Benchmark.measure {
  1000.times do |n|
    Animal.create
  end
}
puts "Time to create 1000 animals (no encrypted id): #{time.real}"