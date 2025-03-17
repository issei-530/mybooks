class UserBooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_book = UserBook.find(params[:id])
  end

  def destroy
    @user_book = UserBook.find(params[:id])

    if @user_book.user = current_user
      @user_book.destroy
      redirect_to my_list_user_path(current_user), notice: '本をマイリストから削除しました。'
    else
      redirect_to my_list_user_path(current_user), alert: '本の削除に失敗しました。'
    end
  end
end
