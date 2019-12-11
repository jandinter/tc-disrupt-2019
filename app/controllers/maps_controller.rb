class MapsController < ApplicationController

  # GET /maps
  # GET /maps.json
  def index
    @maps
  end

  # GET maps/widget
  def widget

  end

  def create_widget

  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:location, :lat, :long, :radius, :widget)
    end
end
