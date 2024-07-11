class Api::BooksController < BaseBooksController
  def show
    if @book.present?
      render json: book_details(@book), status: :ok
    else
      render 'books/not_found', status: :not_found
    end
  end

  private

  def book_details(book)
    {
      title: book.title,
      author: book.authors.map { |author| author.full_name }.join(", "),
      isbn_13: params[:id].delete('-'),
      isbn_10: @converter.convert_to_isbn10,
      publisher: book.publisher.name,
      publication_year: book.publication_year,
      edition: book.edition,
      price: book.list_price.to_f
    }
  end
end
