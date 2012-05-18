class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def create
    clean_params = params[:book].slice(:title)
    book = Book.new(clean_params)
    if book.save
      render json: { title: book.title }, status: :ok
    else
      render json: { errors: book.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    book = Book.find(params[:id])

    if book.destroy
      render json: { success: true }, status: :ok
    else
      render json: { success: false }, status: :bad_request
    end
  end
end
