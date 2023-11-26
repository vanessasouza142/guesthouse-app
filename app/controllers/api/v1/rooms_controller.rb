class Api::V1::RoomsController < Api::V1::ApiController

  def index
    guesthouse = Guesthouse.find(params[:guesthouse_id])
    rooms = guesthouse.rooms.available
    render status: 200, json: rooms.as_json(only: [:name, :description, :area, :max_guest, :default_price])
  end

end
