# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :user, inverse_of: :bulletins
  belongs_to :category, inverse_of: :bulletins

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :image, presence: true, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }
end
