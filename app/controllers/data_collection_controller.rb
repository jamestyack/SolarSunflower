class DataCollectionController < ApplicationController
	def submit	
		data_collection = DataCollection.new(params[:data])
		data_collection.save!
		respond_to do |format|
  	  format.json { head :ok }
  	end
	end

        def index
            if params[:site_id]
                @site = Site.find(params[:site_id])
                @data_collections = @site.data_collections.all(:order => 'collected_date DESC')
            else
                @data_collections = DataCollection.all(:order => "collected_date DESC")
            end
        end
end
