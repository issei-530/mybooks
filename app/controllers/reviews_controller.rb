class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @book, notice: '感想を投稿しました！'
    else
      redirect_to @book, alert: '感想の投稿に失敗しました。'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
