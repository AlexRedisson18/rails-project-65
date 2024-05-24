# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
end
