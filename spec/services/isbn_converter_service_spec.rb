require 'rails_helper'

RSpec.describe IsbnConverterService do
  let(:valid_isbn13) { '978-1-891830-85-3' }
  let(:valid_isbn10) { '1-891830-85-6' }
  let(:invalid_isbn13) { '978-1-891830-85-0' }
  let(:invalid_isbn10) { '1-891830-85-0' }

  describe '#valid_isbn13?' do
    it 'returns true for a valid ISBN-13' do
      converter = IsbnConverterService.new(valid_isbn13)
      expect(converter.valid_isbn13?).to be true
    end

    it 'returns false for an invalid ISBN-13' do
      converter = IsbnConverterService.new(invalid_isbn13)
      expect(converter.valid_isbn13?).to be false
    end
  end

  describe '#valid_isbn10?' do
    it 'returns true for a valid ISBN-10' do
      converter = IsbnConverterService.new(valid_isbn10)
      expect(converter.valid_isbn10?).to be true
    end

    it 'returns false for an invalid ISBN-10' do
      converter = IsbnConverterService.new(invalid_isbn10)
      expect(converter.valid_isbn10?).to be false
    end
  end

  describe '#convert_to_isbn13' do
    it 'converts a valid ISBN-10 to ISBN-13' do
      converter = IsbnConverterService.new(valid_isbn10)
      expect(converter.convert_to_isbn13).to eq('9781891830853')
    end

    it 'returns nil for an invalid ISBN-10' do
      converter = IsbnConverterService.new(invalid_isbn10)
      expect(converter.convert_to_isbn13).to be_nil
    end
  end

  describe '#convert_to_isbn10' do
    it 'converts a valid ISBN-13 to ISBN-10' do
      converter = IsbnConverterService.new(valid_isbn13)
      expect(converter.convert_to_isbn10).to eq('1891830856')
    end

    it 'returns nil for an invalid ISBN-13' do
      converter = IsbnConverterService.new(invalid_isbn13)
      expect(converter.convert_to_isbn10).to be_nil
    end
  end
end
