class ReviewsController < ApplicationController

  def new
    @booking = Booking.find(params[:booking_id])
    @review = @booking.build_review
  end

end