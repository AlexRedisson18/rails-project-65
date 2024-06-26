# frozen_string_literal: true

class Web::Admin::AdminController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.under_moderation.order(created_at: :desc).page(params[:page]).per(10)
  end
end
