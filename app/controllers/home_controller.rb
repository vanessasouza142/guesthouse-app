class HomeController < ApplicationController

  def index
    @latest_guesthouses = Guesthouse.active.last(3)
    @guesthouses = Guesthouse.active.order(:brand_name)
    @guesthouse_cities = Guesthouse.active.distinct.pluck(:city)
  end

end