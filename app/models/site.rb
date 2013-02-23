class Site < ActiveRecord::Base
  attr_accessible :address, :description, :name, :zipcode
end
