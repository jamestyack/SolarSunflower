class DataCollectionController < ApplicationController

    def submit
        if params[:type] == 'soilmoisture'
            redirect_to create_soilmoisture_path(:data => params[:data])
        end

        respond_to do |format|
            format.json { head :ok }
        end
    end
