class Site < ActiveRecord::Base
  attr_accessible :address, :description, :name, :zipcode

  has_many :data_collections, :dependent => :destroy
end
