# == Schema Information
#
# Table name: authors_books
#
#  id         :integer          not null, primary key
#  author_id  :integer          not null
#  book_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class AuthorsBookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
