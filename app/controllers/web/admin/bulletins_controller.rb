# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :find_bulletin, only: %i[publish reject archive]

  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def publish
    if @bulletin.may_publish?
      @bulletin.publish!
      flash[:notice] = t('admin.bulletins.publish.flash.notice')
    else
      flash[:alert] = t('admin.bulletins.publish.flash.alert')
    end
    redirect_to admin_root_path
  end

  def reject
    if @bulletin.may_reject?
      @bulletin.reject!
      flash[:notice] = t('admin.bulletins.reject.flash.notice')
    else
      flash[:alert] = t('admin.bulletins.reject.flash.alert')
    end
    redirect_to admin_root_path
  end

  def archive
    if @bulletin.may_archive?
      @bulletin.archive!
      flash[:notice] = t('admin.bulletins.archive.flash.notice')
    else
      flash[:alert] = t('admin.bulletins.archive.flash.alert')
    end
    redirect_to admin_root_path
  end

  private

  def find_bulletin
    @bulletin = Bulletin.find(params[:id])
    # authorize @bulletin
  end
end
