# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :find_bulletin, only: %i[show edit update]

  def index
    @bulletins = Bulletin.includes(:category, :user).order(created_at: :desc)
  end

  def show; end

  def new
    @bulletin = Bulletin.build
  end

  def edit; end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      flash[:notice] = t('bulletins.create.flash.notice')
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      flash[:notice] = t('admin.bulletins.update.flash.notice')
      redirect_to bulletins_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def find_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
