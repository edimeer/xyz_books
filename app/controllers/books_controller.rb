class BooksController < BaseBooksController
  def show
    if @book.present?
      respond_to do |format|
        format.html { render :show, locals: { book: @book } }
      end
    else
      render 'books/not_found', status: :not_found
    end
  end
end
