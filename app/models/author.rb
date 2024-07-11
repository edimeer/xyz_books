# == Schema Information
#
# Table name: authors
#
#  id          :integer          not null, primary key
#  first_name  :string           not null
#  last_name   :string           not null
#  middle_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Author < ApplicationRecord
  has_and_belongs_to_many :books

  validates :first_name, :last_name, presence: true

  def full_name
    if self.middle_name.present?
      "#{self.first_name} #{self.middle_name} #{self.last_name}"
    else
      "#{self.first_name} #{self.last_name}"
    end
  end
end
