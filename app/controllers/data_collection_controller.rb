class DataCollectionController < ApplicationController
	def submit
	end

        def index
            if params[:site_id]
                @data_collections = DataCollection.find_by_site_id(params[:site_id])
            else
                @data_collections = DataCollection.all(:order => "collected_date DESC")
            end
        end
end
