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
require "test_helper"

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
