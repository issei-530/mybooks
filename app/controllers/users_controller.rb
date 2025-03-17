class UsersController < ApplicationController
  before_action :authenticate_user!

  def my_list
    @user = User.find(params[:id])
    @books = @user.user_books.includes(:book)
  end
end
