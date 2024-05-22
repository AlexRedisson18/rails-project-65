# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :email, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
