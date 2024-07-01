# frozen_string_literal: true

class BulletinPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    @user = user
    @bulletin = bulletin
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
    admin? || author?
  end

  def update?
    admin? || author?
  end

  def archive?
    admin? || author?
  end

  def to_moderate?
    author?
  end

  def reject?
    admin?
  end

  def publish?
    admin?
  end

  private

  def author?
    bulletin.user == user
  end

  def admin?
    user&.admin?
  end
end
