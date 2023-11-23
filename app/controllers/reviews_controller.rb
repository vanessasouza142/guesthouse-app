class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_host_to_new

  def new
    @booking = Booking.find(params[:booking_id])
    @review = @booking.build_review
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = @booking.build_review(review_params)
    if @review.save
      redirect_to @booking, notice: 'Avaliação registrada com sucesso.'
    else
      flash.now[:notice] = 'Avaliação não registrada.'
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:score, :review_text)
  end

end