class SitesController < ApplicationController
    def show
        @site = Site.find(params[:id])
        @collection_points = @site.collection_points
        @soilmoistures = {}

        @collection_points.each do |point|
            @soilmoistures[point.name] = []

            point.soilmoistures.each do |soil|
                @soilmoistures[point.name] << soil
            end
        end


        respond_to do |format|
            format.html
            format.json { render :json => @soilmoistures.to_json }
        end
    end
end
