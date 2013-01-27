
class Toilet < ActiveRecord::Base

  has_many :toilet_rating
  attr_accessible :name, :address, :price, :latitude, :longitude, :has_male, :has_female, :has_both, :has_family, :has_free_access, :gmaps
  attr_accessor :score 
end
