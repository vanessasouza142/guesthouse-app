class HomeController < ApplicationController
  before_action :redirect_host_to_new

  def index
    @guesthouses = Guesthouse.active
    @latest_guesthouses = Guesthouse.active.last(3)
    @rest_guesthouses = Guesthouse.active - @latest_guesthouses
    @guesthouse_cities = Guesthouse.active.order(:city).distinct.pluck(:city)
  end

end