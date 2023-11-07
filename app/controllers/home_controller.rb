class HomeController < ApplicationController

  def index
    @latest_guesthouses = Guesthouse.active.last(3)
    @guesthouses = Guesthouse.active.order(:brand_name)
  end

end