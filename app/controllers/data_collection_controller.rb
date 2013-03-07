class DataCollectionController < ApplicationController

    def submit
        if params[:type] == 'soilmoisture'
            Soilmoisture.create!(params[:data])
        end

        respond_to do |format|
            format.json { head :ok }
        end
    end

end
