# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  def show
    @bulletins = Bulletin.includes(:category, :user).order(created_at: :desc)
  end
end
