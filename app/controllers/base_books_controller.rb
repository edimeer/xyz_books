class BaseBooksController < ApplicationController
  before_action :set_converter, :check_isbn_validity, :find_book

  def set_converter
    isbn = params[:id]

    @converter ||= IsbnConverterService.new(isbn)
  end

  def check_isbn_validity
    if !@converter.valid_isbn13? && !@converter.valid_isbn10?
      render 'books/invalid_isbn', status: :bad_request
    end
  end

  def find_book
    @book ||= if @converter.valid_isbn13?
             Book.find_by_isbn(params[:id].delete('-'))
           elsif @converter.valid_isbn10?
             Book.find_by_isbn(@converter.convert_to_isbn13)
           end
  end
end
