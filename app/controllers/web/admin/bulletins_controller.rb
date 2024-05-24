# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  # before_action :find_bulletin, only: %i[]

  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  # private

  # def find_bulletin
  #   @bulletin = Bulletin.find(params[:id])
  # end

  # def bulletin_params
  #   params.require(:bulletin).permit(:title, :description, :category_id, :image)
  # end
end
