class CollectionPoint < ActiveRecord::Base
  attr_accessible :title, :body

  belongs_to :site
  has_many :data_collections
  has_many :soilmoistures

end
