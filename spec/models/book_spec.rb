require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:publisher) { Publisher.create(name: 'Test Publisher') }

  it "is valid with valid attributes" do
    book = Book.new(title: 'Test Book', isbn_13: '1234567890123', list_price: 19.99, publication_year: 2021, publisher: publisher)
    expect(book).to be_valid
  end

  it "is not valid without a title" do
    book = Book.new(title: nil, isbn_13: '1234567890123', list_price: 19.99, publication_year: 2021, publisher: publisher)
    expect(book).not_to be_valid
  end

  it "is not valid without an ISBN-13" do
    book = Book.new(title: 'Test Book', isbn_13: nil, list_price: 19.99, publication_year: 2021, publisher: publisher)
    expect(book).not_to be_valid
  end

  it "is not valid without a list price" do
    book = Book.new(title: 'Test Book', isbn_13: '1234567890123', list_price: nil, publication_year: 2021, publisher: publisher)
    expect(book).not_to be_valid
  end

  it "is not valid without a publication year" do
    book = Book.new(title: 'Test Book', isbn_13: '1234567890123', list_price: 19.99, publication_year: nil, publisher: publisher)
    expect(book).not_to be_valid
  end

  it "is not valid without a publisher" do
    book = Book.new(title: 'Test Book', isbn_13: '1234567890123', list_price: 19.99, publication_year: 2021, publisher: nil)
    expect(book).not_to be_valid
  end

  describe '.find_by_isbn' do
    context 'when searching with a valid ISBN-13' do
      it 'returns the correct book' do
        expect(Book.find_by_isbn("978-1-891830-85-3")).to eq(@book1)
      end
    end

    context 'when searching with an invalid ISBN' do
      it 'returns nil' do
        expect(Book.find_by_isbn("978-1-891830-85-0")).to be_nil
      end
    end

    context 'when searching with an ISBN without hyphens' do
      it 'returns the correct book for ISBN-13' do
        expect(Book.find_by_isbn("9781891830853")).to eq(@book1)
      end
    end
  end
end
