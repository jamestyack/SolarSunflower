class DataCollectionController < ApplicationController
	def submit	
		data_collection = DataCollection.new(params[:data])
		data_collection.save!
		respond_to do |format|
  	  format.json { head :ok }
  	end
	end

        def index
        end
end
