class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_host_to_new
  before_action only: [:new, :create] do
    @booking = Booking.find(params[:booking_id])
    check_user(@booking)
  end
  before_action only: [:answer, :register_answer] do
    @review = Review.find(params[:id])
    @guesthouse = @review.booking.room.guesthouse
    check_user(@guesthouse)
  end

  def new
    @review = @booking.build_review
  end

  def create
    @review = @booking.build_review(review_params)
    if @review.save
      redirect_to @booking, notice: 'Avaliação registrada com sucesso.'
    else
      flash.now[:notice] = 'Avaliação não registrada.'
      render 'new'
    end
  end

  def answer
    @booking = @review.booking
  end

  def register_answer
    @booking = @review.booking
    @review.answer = params[:review][:answer]
    if @review.save
      redirect_to @booking, notice: "Resposta registrada com sucesso."
    else
      flash.now[:notice] = "Resposta não registrada."
      render 'answer'
    end
  end

  private

  def review_params
    params.require(:review).permit(:score, :review_text)
  end

end