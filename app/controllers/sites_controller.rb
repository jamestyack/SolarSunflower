class SitesController < ApplicationController
    def show
        @site = Site.find(params[:id])
        @collection_points = @site.collection_points
        @soilmoistures = []
        @soilmoisture_points_a = {:name => 'Depth A', :data => {}}
        @soilmoisture_points_b = {:name => 'Depth B', :data => {}}
        @soilmoisture_points_c = {:name => 'Depth C', :data => {}}
        @collection_points.first.soilmoistures.each do |point|
            @soilmoisture_points_a[:data][point.created_at] = point.deptha
            @soilmoisture_points_b[:data][point.created_at] = point.depthb
            @soilmoisture_points_c[:data][point.created_at] = point.depthc
        end

        @all_points = []
        @all_points << @soilmoisture_points_a
        @all_points << @soilmoisture_points_b
        @all_points << @soilmoisture_points_c

        respond_to do |format|
            format.html
        end
    end
end
