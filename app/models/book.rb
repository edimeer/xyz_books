# == Schema Information
#
# Table name: books
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  isbn_13          :string           not null
#  list_price       :decimal(, )      not null
#  publication_year :integer          not null
#  image_url        :string
#  edition          :string
#  publisher_id     :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Book < ApplicationRecord
  belongs_to :publisher
  has_and_belongs_to_many :authors

  validates :title, :isbn_13, :list_price, :publication_year, :publisher, presence: true

  def self.find_by_isbn(isbn)
    return unless isbn.present?
    sanitized_isbn = isbn.delete('-')
    where("REPLACE(isbn_13, '-', '') = ?", sanitized_isbn).first
  end
end
