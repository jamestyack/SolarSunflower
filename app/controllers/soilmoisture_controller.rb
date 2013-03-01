class SoilmoistureController < ApplicationController
    def create
        @soilmoisture = Soilmoisture.new(params[:data])
        @soilmoisture.save!
    end
end
