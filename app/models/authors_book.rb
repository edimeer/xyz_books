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
class AuthorsBook < ApplicationRecord
end
