class DataCollectionController < ApplicationController
	def submit
	end

        def index
            @data_collections = DataCollection.all(:order => "collected_date DESC")
        end
end
