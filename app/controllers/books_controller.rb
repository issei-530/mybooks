class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :show]
  before_action :move_to_index, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_to_mylist, :remove_from_mylist]
  
  def index
    @books = Book.all

    if params[:search].present?
      @books = @books.where('books.title LIKE ?', "%#{params[:search]}%")
    end

    if params[:keyword].present?
      @books = @books.joins(:reviews).where('reviews.content LIKE ?', "%#{params[:keyword]}%").distinct
    end
  end

  def show
    @book = Book.find(params[:id])
    @review = Review.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to root_path, notice: '本が投稿されました。'
    else
      Rails.logger.debug @book.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: '本の情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: '本が削除されました。'
  end

  def add_to_mylist
    @book = Book.find(params[:id])
    current_user.books << @book
    redirect_to @book, notice: '本がマイリストに追加されました！'
  end
  
  def remove_from_mylist
    current_user.books.delete(@book)
    redirect_to books_path, notice: 'Book was successfully removed from your list.'
  end
  
  private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, :description, :user_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
