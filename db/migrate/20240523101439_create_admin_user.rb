class CreateAdminUser < ActiveRecord::Migration[7.1]
  def change
    admin_user = User.find_or_create_by(email: 'alexandr_kitchenko@mail.ru')
    admin_user.update(name: 'Alexander K', admin: true)
  end
end
