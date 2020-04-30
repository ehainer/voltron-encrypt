class Car < ActiveRecord::Base

  encrypted_id

  has_many :user_cars

  has_many :users, through: :user_cars

end
