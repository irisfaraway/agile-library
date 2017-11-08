# Book object
class Book < ApplicationRecord
  include CanChangeStatus

  validates :title, presence: true, uniqueness: true

  validates :author, presence: true
end
