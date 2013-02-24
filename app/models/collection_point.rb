class CollectionPoint < ActiveRecord::Base
  attr_accessible :name

  belongs_to :site
  has_many :data_collections
end
