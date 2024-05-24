# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new edit create update to_moderate archive]
  before_action :find_bulletin, only: %i[edit update to_moderate archive]

  def index
    @bulletins = Bulletin.includes(:category, :user).order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.build
    authorize @bulletin
  end

  def edit; end

  def create
    authorize Bulletin

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
      flash[:notice] = t('bulletins.update.flash.notice')
      redirect_to bulletins_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def to_moderate
    if @bulletin.may_to_moderate?
      @bulletin.to_moderate!
      flash[:notice] = t('bulletins.to_moderate.flash.notice')
    else
      flash[:alert] = t('bulletins.to_moderate.flash.alert')
    end
    redirect_to profile_path
  end

  def archive
    if @bulletin.may_archive?
      @bulletin.archive!
      flash[:notice] = t('bulletins.archive.flash.notice')
    else
      flash[:alert] = t('bulletins.archive.flash.alert')
    end
    redirect_to profile_path
  end

  private

  def find_bulletin
    @bulletin = current_user.bulletins.find(params[:id])

    authorize @bulletin
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
