class Course < ApplicationRecord
  validates :code, presence: true, uniqueness: true

  has_many :tutors
  accepts_nested_attributes_for :tutors
end
