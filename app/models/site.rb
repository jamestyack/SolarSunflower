class Site < ActiveRecord::Base
  attr_accessible :address, :description, :name, :zipcode

  has_many :data_collections, :dependent => :destroy
  has_many :collection_points
end
