# XYZ Books

**Project Description:** A brief description of what your project does and who it's for.

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Migrations and Seeding](#migrations-and-seeding)
- [Usage](#usage)
- [Run rspec tests](#run-rspec-tests)

## Requirements

- Ruby version: 3.0.0
- Rails version: 7.1.3

## Installation

1. Clone the repository:
    ```bash
    git clone git@github.com:edimeer/xyz_books.git
    cd xyz_books
    ```

2. Install dependencies:
    ```bash
    bundle install
    ```
    
## Migrations and Seeding

1. Run database migrations:
    ```bash
    rails db:migrate
    ```

2. Seed the database:
    ```bash
    rails db:seed
    ```

## Run rspec tests
1. Run rspec
    ```bash
    bundle exec rspec
    ```

## Usage

1. Build TailwindCSS:
    ```bash
    ./bin/dev
    ```

2. Start the Rails server:
    ```bash
    rails server
    ```

After running the rails server and going to `localhost:3000` this is how it should look like
![image](https://github.com/edimeer/xyz_books/assets/44763393/dce27539-5979-403d-87b4-c87b0ddc3287)

## `IsbnConverterService` Explanation
`app/services/isbn_converter_service.rb`

The `IsbnConverterService` class validates and converts ISBN numbers between 10-digit and 13-digit formats. Below are the key methods and their functionalities:

### Key Methods

#### `initialize(isbn)`
- Initializes the service with a given ISBN, removing any hyphens.

#### `valid_isbn13?`
- Checks if the provided ISBN is a valid 13-digit ISBN. Returns `true` if valid, `false` otherwise.

#### `valid_isbn10?`
- Checks if the provided ISBN is a valid 10-digit ISBN. Returns `true` if valid, `false` otherwise.

#### `convert_to_isbn13`
- Converts a valid 10-digit ISBN to a 13-digit ISBN. Returns the 13-digit ISBN as a string, or `nil` if the ISBN is not valid.

#### `convert_to_isbn10`
- Converts a valid 13-digit ISBN to a 10-digit ISBN. Returns the 10-digit ISBN as a string, or `nil` if the ISBN is not valid or cannot be converted.

### Private Methods

#### `valid_check_digit_13?`
- Calculates the sum of the digits, multiplying every second digit by 3. The sum must be divisible by 10.

#### `valid_check_digit_10?`
- Calculates the sum of the digits, with the first digit multiplied by 10, the second by 9, and so on. The sum must be divisible by 11.

#### `calculate_isbn13_check_digit(isbn13_body)`
- Calculates the sum of the digits, multiplying every second digit by 3. The check digit ensures the sum is divisible by 10.

#### `calculate_isbn10_check_digit(isbn10_body)`
- Calculates the sum of the digits, with the first digit multiplied by 10, the second by 9, and so on. The check digit ensures the sum is divisible by 11, using 'X' if the check digit is 10.

### Testing
- RSpec tests have been written to ensure the functionality and reliability of the `IsbnConverterService` class. These tests are located in the `spec/services/isbn_converter_service_spec.rb` file.



## Models Explanation

### `Author` model

#### Relationships:
- `has_and_belongs_to_many :books`: Defines a many-to-many relationship between `Author` and `Book` models.

#### Validations:
- `validates :first_name, :last_name, presence: true`: Ensures that `first_name` and `last_name` attributes cannot be blank.

#### Class Method:
- `def full_name`: Constructs and returns the full name of the author. If `middle_name` is present, it includes it in the format `"first_name middle_name last_name"`; otherwise, it returns `"first_name last_name"`.

### `Book` model

#### Relationships:
- `belongs_to :publisher`: Establishes a one-to-one relationship between `Book` and `Publisher` models.
- `has_and_belongs_to_many :authors`: Defines a many-to-many relationship between `Book` and `Author` models.

#### Validations:
- `validates :title, :isbn_13, :list_price, :publication_year, :publisher, presence: true`: Ensures that `title`, `isbn_13`, `list_price`, `publication_year`, and `publisher` attributes cannot be blank.

#### Class Method:
- `def self.find_by_isbn(isbn)`: Finds a book by its ISBN number. It sanitizes the ISBN by removing hyphens and performs a case-insensitive search using SQL `WHERE` clause with `REPLACE` function.

### `Publisher` class

#### Relationships:
- `has_many :books`: Establishes a one-to-many relationship between `Publisher` and `Book` models.

#### Validations:
- `validates :name, presence: true`: Ensures that `name` attribute cannot be blank.

### Testing
- RSpec tests have been written to ensure the functionality and reliability of these `model` classes. These tests are located in the `spec/models/` file.


## Controllers Explanation

### `BaseBooksController`
`app/controllers/base_books_controller.rb`

#### Before Actions:
- `before_action :set_converter, :check_isbn_validity, :find_book`: Executes `set_converter`, `check_isbn_validity`, and `find_book` methods before each action in the controller.

#### Methods:
- `set_converter`:
  - Initializes an `IsbnConverterService` instance with the ISBN from the request parameters.

- `check_isbn_validity`:
  - Checks the validity of the ISBN using the `IsbnConverterService`. Renders an 'invalid_isbn' view with a `bad_request` status if the ISBN is not valid.

- `find_book`:
  - Finds a book based on the validated ISBN provided using `Book.find_by_isbn`.

### `BooksController`
`app/controllers/books_controller.rb`

#### Inherits from:
- `BaseBooksController`: Inherits behavior and methods from `BaseBooksController`.

#### Actions:
- `show`:
  - Displays the details of a book.
  - Renders the `show` view with the book details if found.
  - Renders 'not_found' view with `not_found` status if the book is not found.

#### Endpoint:
- `/books/:id` where :id is ISBN 13 or ISBN 10


![image](https://github.com/edimeer/xyz_books/assets/44763393/3085730d-b3f4-45a0-9a67-5056a242f3cf)

#### On this part of the instruction, i am not sure if it means the same API that displays the show view of the book or a separate API that only returns the JSON form of the book so I made another API for that:

### `Api::BooksController`

#### Inherits from:
- `BaseBooksController`: Inherits behavior and methods from `BaseBooksController`.

#### Actions:
- `show`:
  - Returns JSON representation of book details.
  - Uses `book_details` private method to construct and render JSON containing attributes like title, authors, ISBNs, publisher, publication year, edition, and price.
  - Renders 'not_found' view with `not_found` status if the book is not found.

#### Endpoint:
- `api/books/:id` where :id is ISBN 13 or ISBN 10

### Testing
- RSpec tests have been written to ensure the functionality and reliability of these `controller` classes. These tests are located in the `spec/requests/` file.
