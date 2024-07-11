require 'rails_helper'

RSpec.describe "Api::Books", type: :request do
  before(:each) do
    @publisher = Publisher.create!(name: "Sample Publisher")
    @book1 = Book.create!(
      title: "Sample Book 1",
      isbn_13: "978-1-891830-85-3",
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
      isbn_13: "978-1-60309-454-2",
      list_price: 2000,
      publication_year: 2019,
      publisher: Publisher.create!(name: "Another Publisher"),
      authors: [
        Author.create!(first_name: "Author3", last_name: "Three"),
        Author.create!(first_name: "Author4", last_name: "Four")
      ]
    )
  end

  describe "GET /api/books/:id" do
    context "with a valid ISBN-13" do
      it "returns the correct book details" do
        get "/api/books/978-1-891830-85-3"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("Sample Book 1")
        expect(json["author"]).to eq("Author1 One, Author2 Two")
        expect(json["isbn_13"]).to eq("9781891830853")
        expect(json["isbn_10"]).to eq("1891830856")
        expect(json["publisher"]).to eq("Sample Publisher")
        expect(json["publication_year"]).to eq(2004)
        expect(json["price"]).to eq(1000)
      end

      it "returns the correct book details even without hyphens" do
        get "/api/books/9781891830853"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("Sample Book 1")
      end
    end

    context "with a valid ISBN-10" do
      it "returns the correct book details" do
        get "/api/books/1-891830-85-6"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("Sample Book 1")
      end

      it "returns the correct book details even without hyphens" do
        get "/api/books/1891830856"
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["title"]).to eq("Sample Book 1")
      end
    end

    context "with an invalid ISBN" do
      it "returns a bad request status" do
        get "/api/books/invalid-isbn"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
