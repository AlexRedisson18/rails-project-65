# frozen_string_literal: true

class BulletinPolicy
  attr_reader :user, :bulletin

  def initialize(user, book)
    @user = user
    @book = book
  end
  # BEGIN

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

  def destroy?
    admin?
  end

  private

  def author?
    bulletin.user == user
  end

  def admin?
    user&.admin?
  end
  # END
end
