require 'rails_helper'

RSpec.describe "Books", type: :request do
  before(:each) do
    @publisher = Publisher.create!(name: "Sample Publisher")
    @book1 = Book.create!(
      title: "Sample Book 1",
      isbn_13: "9781891830853",
      list_price: 1000,
      publication_year: 2004,
      publisher: @publisher,
      authors: [
        Author.create!(first_name: "Author1", last_name: "One"),
        Author.create!(first_name: "Author2", last_name: "Two")
      ]
    )

    @book2 = Book.create!(
      title: "Sample Book 2",
      isbn_13: "9781603094542",
      list_price: 2000,
      publication_year: 2019,
      publisher: Publisher.create!(name: "Another Publisher"),
      authors: [
        Author.create!(first_name: "Author3", last_name: "Three"),
        Author.create!(first_name: "Author4", last_name: "Four")
      ]
    )
  end

  describe "GET /books/:id" do
    context "with a valid ISBN-13" do
      it "returns the correct book" do
        get "/books/978-1-891830-85-3"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Sample Book 1")
      end

      it "returns the correct book even without hyphens" do
        get "/books/9781891830853"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Sample Book 1")
      end
    end

    context "with a valid ISBN-10" do
      it "returns the correct book" do
        get "/books/1-891830-85-6"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Sample Book 1")
      end

      it "returns the correct book even without hyphens" do
        get "/books/1891830856"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Sample Book 1")
      end
    end

    context "with an invalid ISBN" do
      it "returns a bad request status" do
        get "/books/invalid-isbn"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
