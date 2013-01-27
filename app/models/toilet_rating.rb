class ToiletRating < ActiveRecord::Base
  belongs_to :toilet
  attr_accessible :cleanness, :comfort, :comment, :has_hook, :has_tissue, :privacy, :safety, :toilet_id
end
