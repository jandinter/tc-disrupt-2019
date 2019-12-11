class UpdatesController < ApplicationController

  def index
    @tweets = ::Cruncher::TwitterCruncher.new.update(lat: params[:lat], long: params[:long], radius: "#{params[:radius].to_i/1000}km")
    puts "Tweets: #{@tweets}"
    render json: @tweets
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def map_params
      params.require(:map).permit(:location, :lat, :long, :radius, :widget)
    end
end
