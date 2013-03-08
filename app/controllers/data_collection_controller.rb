class DataCollectionController < ApplicationController

    skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

    def submit
        if params[:type] == 'soilmoisture'
            Soilmoisture.create!(params[:data])
        end

        respond_to do |format|
            format.json { head :ok }
        end
    end

end
