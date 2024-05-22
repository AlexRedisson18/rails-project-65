# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :find_bulletin, only: %i[]

  def index
    @bulletins = Bulletin.includes(:category, :user).order(created_at: :desc)
  end

  def new
    @bulletin = Bulletin.build
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      flash[:notice] = t('bulletins.flash.notice')
      # redirect_to @post
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def show
  # end

  # def edit
  # end

  # def update
  # end

  # def delete
  # end

  private

  def find_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
