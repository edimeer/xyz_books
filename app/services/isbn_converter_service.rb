class IsbnConverterService
  def initialize(isbn)
    @isbn = isbn.delete('-')
  end

  def valid_isbn13?
    @isbn.match?(/\A\d{13}\z/) && valid_check_digit_13?
  end

  def valid_isbn10?
    @isbn.match?(/\A\d{9}[0-9X]\z/) && valid_check_digit_10?
  end

  def convert_to_isbn13
    return nil unless valid_isbn10? || valid_isbn13?

    isbn10_digits = @isbn[0..8]
    isbn13_body = "978" + isbn10_digits
    check_digit = calculate_isbn13_check_digit(isbn13_body)
    isbn13_body + check_digit
  end

  def convert_to_isbn10
    return nil unless (valid_isbn13? && @isbn.start_with?("978")) || valid_isbn10?

    isbn10_body = @isbn[3..11]
    check_digit = calculate_isbn10_check_digit(isbn10_body)
    isbn10_body + check_digit
  end

  private

  def valid_check_digit_13?
    sum = 0
    @isbn.chars.each_with_index do |char, index|
      digit = char.to_i
      sum += index.even? ? digit : digit * 3
    end
    sum % 10 == 0
  end

  def valid_check_digit_10?
    sum = 0
    @isbn.chars.each_with_index do |char, index|
      digit = (char == 'X' ? 10 : char.to_i)
      sum += digit * (10 - index)
    end
    sum % 11 == 0
  end

  def calculate_isbn13_check_digit(isbn13_body)
    sum = 0
    isbn13_body.chars.each_with_index do |char, index|
      digit = char.to_i
      sum += index.even? ? digit : digit * 3
    end
    remainder = sum % 10
    check_digit = (10 - remainder) % 10
    check_digit.to_s
  end

  def calculate_isbn10_check_digit(isbn10_body)
    sum = 0
    isbn10_body.chars.each_with_index do |char, index|
      digit = char.to_i
      sum += digit * (10 - index)
    end
    remainder = sum % 11
    check_digit = (11 - remainder) % 11
    check_digit == 10 ? 'X' : check_digit.to_s
  end
end
