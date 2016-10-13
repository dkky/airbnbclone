class ReviewsController < ApplicationController
  before_action :find_review, only: [:update, :edit]

  def new
    @review = Review.new
  end

  def create
    @event = Event.find_by(title: review_params[:event_title])
    @review = Review.new(review_params)

    if @review.save
      @user = User.find(params[:user_id].to_i)
      @review.update(event_id: @event.id)
      @review.update(user_id: current_user.id)
      redirect_to @user
    else
      render 'new'
    end

    # respond_to do |format|
    #   if @review.save
    #     @review.update(user_id: params[:user_id].to_i)
    #     gon.last_id = @review.id
    #     format.html {}
    #     format.js   {}
    #     format.json { render json: @review.id, status: :created}
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @review.errors, status: :unprocessable_entity }
    #   end
    # end

  end


  def edit
  end

  def update
  end

  private

  def review_params   
    params.require(:review).permit(:score, :comment, :event_title)
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
