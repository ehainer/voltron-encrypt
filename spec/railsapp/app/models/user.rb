class User < ActiveRecord::Base

  encrypted_id

  has_many :user_cars

  has_many :user_animals

  has_many :cars, through: :user_cars

  has_many :animals, through: :user_animals

  belongs_to :car, class_name: "Car"

end
