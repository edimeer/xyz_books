require 'rails_helper'

RSpec.describe Author, type: :model do
  it "is valid with valid attributes" do
    author = Author.new(first_name: 'John', last_name: 'Doe')
    expect(author).to be_valid
  end

  it "is not valid without a first name" do
    author = Author.new(first_name: nil, last_name: 'Doe')
    expect(author).not_to be_valid
  end

  it "is not valid without a last name" do
    author = Author.new(first_name: 'John', last_name: nil)
    expect(author).not_to be_valid
  end

  it "can have a middle name" do
    author = Author.new(first_name: 'John', last_name: 'Doe', middle_name: 'A.')
    expect(author).to be_valid
  end
end
