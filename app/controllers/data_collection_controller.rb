class DataCollectionController < ApplicationController

    skip_before_filter :verify_authenticity_token

    def submit
        if params[:type] == 'soilmoisture'
            Soilmoisture.create!(params[:data])
        end

        respond_to do |format|
            format.json { head :ok }
        end
    end

    private

    def format_js?
        request.format.js?
    end

end
