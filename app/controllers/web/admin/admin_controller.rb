# frozen_string_literal: true

class Web::Admin::AdminController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end
end
